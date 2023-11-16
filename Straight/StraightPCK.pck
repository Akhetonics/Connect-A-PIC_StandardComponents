GDPC                0                                                                         `   res://.godot/exported/133200997/export-5b8bb57ec982ad2052a553f7661f1a17-StraightWaveGuide.scn   @      [      k~Kͮ�G����|�z    `   res://.godot/exported/133200997/export-8154ea41e6cc4381d7df5e6faf09e844-LightOverlayShaded.res         �      ;f�儑�ۛ�_��_�    ,   res://.godot/global_script_class_cache.cfg  06             ��Р�8���8~$}P�    L   res://.godot/imported/Component I.png-9d98366352961baac1c3a9e0ac1d9d47.ctex         �       ��`,��J���eZ    `   res://.godot/imported/Component I_Horizontal_Overlay.png-70612d4de41536e3ac2842c771a3509e.ctex  �      �      �z=�ڲ}���HɌ    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�'      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  :      0      ��[���9�_l��|�    8   res://Scenes/Components/Straight/Component I.png.import �       �       ݋!NO��,r�) �    L   res://Scenes/Components/Straight/Component I_Horizontal_Overlay.png.import  @      �       ZBU�|��p�2�N{�    @   res://Scenes/Components/Straight/LightOverlayShaded.tres.remap  P5      o       z�y�*�ON�F����>�    <   res://Scenes/Components/Straight/StraightDescription.json   �      }      ���kQS�����=    @   res://Scenes/Components/Straight/StraightWaveGuide.tscn.remap   �5      n       ���Y�$q�h�!��       res://icon.svg  P6      �      C��=U���^Qu��U3       res://icon.svg.import   �4      �       ��uO�M׷x��s��       res://project.binary@;      �       ������+�s��}fZ    GST2            ����                        �   RIFF�   WEBPVP8Ly   /@'���$8�
?�!��mnttr.�Dڶ���)�����6S,`�j��\����w���	���6��J�� Q��u y�R�)i-J����u�EI�����u �G%Q$������~ �f��A����[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d3th1vtdpb7mb"
path="res://.godot/imported/Component I.png-9d98366352961baac1c3a9e0ac1d9d47.ctex"
metadata={
"vram_texture": false
}
 D��\�2�GST2   x         ����               x         `  RIFFX  WEBPVP8LL  /w@��4��C�!q�/���|�(�d�9�C98z�&jA�R	Q��D�����������(H������x��|2?�[�h
����W���3R��}����i�#��izk�&���5�ͻ����q�FRTMǙ���ߪ�h:bg��Tn��3D�M� 8"Lsi����&D� � Hͥ��\�4�t(^2'kQ8�5ǹf��dm���	�#��技�\�ؾ��[ڜG������ؾ/˲o)��G�mIsi�ٗם�]�v����	�#���K�Ok��v����$X.�K�O״Q�(s �0ͥ��m�!�cD	�˚K�O7���{��_U޲u���[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dodssmnu1iubn"
path="res://.godot/imported/Component I_Horizontal_Overlay.png-70612d4de41536e3ac2842c771a3509e.ctex"
metadata={
"vram_texture": false
}
 s=ݕ\RSRC                    Shader            ��������                                                  resource_local_to_scene    resource_name    code    script           local://Shader_c6clo �          Shader          �  // Laser Farbe
shader_type canvas_item;
render_mode blend_add;

uniform vec4 laserColor;

uniform vec4 lightInFlow1; // x = intensity, y = phase, z = offsetx, w = offsety
uniform vec4 lightOutFlow1;
uniform vec4 lightInFlow2; 
uniform vec4 lightOutFlow2;
uniform vec4 lightInFlow3; 
uniform vec4 lightOutFlow3;
uniform vec4 lightInFlow4;
uniform vec4 lightOutFlow4;
uniform vec4 lightInFlow5;
uniform vec4 lightOutFlow5;
uniform vec4 lightInFlow6;
uniform vec4 lightOutFlow6;
uniform vec4 lightInFlow7;
uniform vec4 lightOutFlow7;
uniform vec4 lightInFlow8;
uniform vec4 lightOutFlow8;
// ... so viele wie man lustig ist. Am Besten 16 (8 in, 8 out) oder sowas, damit man nur einen einzigen Shader braucht für alle

uniform sampler2D animation1;
uniform sampler2D animation2;
uniform sampler2D animation3;
uniform sampler2D animation4;
uniform sampler2D animation5;
uniform sampler2D animation6;
uniform sampler2D animation7;
uniform sampler2D animation8;
// ... die hälfte von oben, also 8 (in/out ist ja nur umgedreht in der Zeit)
uniform float numAnimationColumns = 4.0;
vec4 getAnimationFrameColor(sampler2D animationTexture, vec2 uvCoord, float elapsedTim2e, float speed, vec4 lightAttributes) {
	float elapsedTime = round(TIME * speed);
    float lightPhase = lightAttributes.y;
	float animationOffset = elapsedTime + round(lightPhase * speed);
	    
    int currentFrameIndex = int(animationOffset) % int(numAnimationColumns);
    float frameShift = float(currentFrameIndex) / numAnimationColumns;
	if(speed < 0.0)
	{
		 frameShift = 1.0 -abs(frameShift- 1.0/numAnimationColumns);
	}
    vec2 adjustedUV = vec2((uvCoord.x / numAnimationColumns + frameShift), uvCoord.y);
    return texture(animationTexture, adjustedUV);
}

float getIntensityOfLight(vec4 currentInflowColor, float lightInflowIntensity){
	
	return currentInflowColor.a *(currentInflowColor.r - currentInflowColor.b) * lightInflowIntensity;
}
void fragment(){
	float animationspeed = 2.0f;
	float animationTime = round(TIME * animationspeed);
	
	vec4 col_baseTexture = texture(TEXTURE, UV);
	vec4 col_anim1in  = getAnimationFrameColor(animation1,UV,animationTime,animationspeed, lightInFlow1);
	vec4 col_anim1out = getAnimationFrameColor(animation1,UV,animationTime,-animationspeed, lightOutFlow1);
    vec4 col_anim2in  = getAnimationFrameColor(animation2,UV,animationTime,animationspeed, lightInFlow2);
	vec4 col_anim2out = getAnimationFrameColor(animation2,UV,animationTime,-animationspeed, lightOutFlow2);
    vec4 col_anim3in  = getAnimationFrameColor(animation3,UV,animationTime,animationspeed, lightInFlow3);
	vec4 col_anim3out = getAnimationFrameColor(animation3,UV,animationTime,-animationspeed, lightOutFlow3);
    vec4 col_anim4in  = getAnimationFrameColor(animation4,UV,animationTime,animationspeed, lightInFlow4);
	vec4 col_anim4out = getAnimationFrameColor(animation4,UV,animationTime,-animationspeed, lightOutFlow4);
    vec4 col_anim5in  = getAnimationFrameColor(animation5,UV,animationTime,animationspeed, lightInFlow5);
	vec4 col_anim5out = getAnimationFrameColor(animation5,UV,animationTime,-animationspeed, lightOutFlow5);
    vec4 col_anim6in  = getAnimationFrameColor(animation6,UV,animationTime,animationspeed, lightInFlow6);
	vec4 col_anim6out = getAnimationFrameColor(animation6,UV,animationTime,-animationspeed, lightOutFlow6);
    vec4 col_anim7in  = getAnimationFrameColor(animation7,UV,animationTime,animationspeed, lightInFlow7);
	vec4 col_anim7out = getAnimationFrameColor(animation7,UV,animationTime,-animationspeed, lightOutFlow7);
    vec4 col_anim8in  = getAnimationFrameColor(animation8,UV,animationTime,animationspeed, lightInFlow8);
	vec4 col_anim8out = getAnimationFrameColor(animation8,UV,animationTime,-animationspeed, lightOutFlow8);
    
  // Der rot Kanal = höhen, z.B.
  // Der blau Kanal = tiefen
  
  float intensity = getIntensityOfLight( col_anim1in, lightInFlow1.x) +
		getIntensityOfLight( col_anim2in, lightInFlow2.x) +
		getIntensityOfLight( col_anim3in, lightInFlow3.x) +
		getIntensityOfLight( col_anim4in, lightInFlow4.x) +
		getIntensityOfLight( col_anim5in, lightInFlow5.x) +
		getIntensityOfLight( col_anim6in, lightInFlow6.x) +
		getIntensityOfLight( col_anim7in, lightInFlow7.x) +
		getIntensityOfLight( col_anim8in, lightInFlow8.x) +
		getIntensityOfLight( col_anim1out, lightOutFlow1.x) +
		getIntensityOfLight( col_anim2out, lightOutFlow2.x) +
		getIntensityOfLight( col_anim3out, lightOutFlow3.x) +
		getIntensityOfLight( col_anim4out, lightOutFlow4.x) +
		getIntensityOfLight( col_anim5out, lightOutFlow5.x) +
		getIntensityOfLight( col_anim6out, lightOutFlow6.x) +
		getIntensityOfLight( col_anim7out, lightOutFlow7.x) +
		getIntensityOfLight( col_anim8out, lightOutFlow8.x);

  COLOR = laserColor * 2.5 * abs(intensity);
}       RSRC�
�锧���{
  "fileFormatVersion": 1,
  "identifier": "Straight",
  "nazcaFunctionParameters": "",
  "nazcaFunctionName": "placeCell_StraightWG",
  "sceneResPath": "res://Scenes/Components/Straight/StraightWaveGuide.tscn",
  "deltaLength": 0,
  "widthInTiles": 1,
  "heightInTiles": 1,
  "pins": [
	{
	  "number": 0,
	  "name": "west0",
	  "matterType": 1,
	  "side": 2,
	  "partX": 0,
	  "partY": 0
	},{
	  "number": 1,
	  "name": "east0",
	  "matterType": 1,
	  "side": 0,
	  "partX": 0,
	  "partY": 0
	}
  ],
  "connections": [
	{
	  "fromPinNr": 0,
	  "toPinNr": 1,
	  "magnitude": 1,
	  "wireLengthNM" : 250000.0
	},
	{
	  "fromPinNr": 1,
	  "toPinNr": 0,
	  "magnitude": 1,
	  "wireLengthNM" : 250000.0
	}
  ],
  "overlays": [
	{
	  "overlayAnimTexturePath": "res://Scenes/Components/GratingCoupler/Grating Coupler Overlay.png",
	  "rectSide": 2,
	  "tileOffsetX": 0,
	  "tileOffsetY": 0
	}
  ]
}
��RSRC                    PackedScene            ��������                                            .      resource_local_to_scene    resource_name    font_names    font_italic    font_weight    font_stretch    antialiasing    generate_mipmaps    allow_system_fallback    force_autohinter    hinting    subpixel_positioning #   multichannel_signed_distance_field    msdf_pixel_range 
   msdf_size    oversampling 
   fallbacks    script    shader    shader_parameter/laserColor    shader_parameter/lightInFlow1    shader_parameter/lightOutFlow1    shader_parameter/lightInFlow2    shader_parameter/lightOutFlow2    shader_parameter/lightInFlow3    shader_parameter/lightOutFlow3    shader_parameter/lightInFlow4    shader_parameter/lightOutFlow4    shader_parameter/lightInFlow5    shader_parameter/lightOutFlow5    shader_parameter/lightInFlow6    shader_parameter/lightOutFlow6    shader_parameter/lightInFlow7    shader_parameter/lightOutFlow7    shader_parameter/lightInFlow8    shader_parameter/lightOutFlow8 %   shader_parameter/numAnimationColumns    shader_parameter/animation1    shader_parameter/animation2    shader_parameter/animation3    shader_parameter/animation4    shader_parameter/animation5    shader_parameter/animation6    shader_parameter/animation7    shader_parameter/animation8 	   _bundled    
   Texture2D 1   res://Scenes/Components/Straight/Component I.png 1�T���-   Shader 9   res://Scenes/Components/Straight/LightOverlayShaded.tres ��{SG��
   Texture2D D   res://Scenes/Components/Straight/Component I_Horizontal_Overlay.png ^l��q      local://SystemFont_r1od1 �         local://ShaderMaterial_ljv2j          local://PackedScene_p2m1r H         SystemFont          w        K                           ,            ShaderMaterial                   2     �?          �?   2     �?                                                                                     !      "      #      $        �@%            &      '      (      )      *      +      ,               PackedScene    -      	         names "         TextureRect    custom_minimum_size    offset_right    offset_bottom    texture    LabelL    layout_mode    offset_top    theme_override_fonts/font $   theme_override_font_sizes/font_size    text    Label    LabelR    offset_left    Overlay 	   material    scale 	   centered 	   Sprite2D    	   variants       
     pB  pB     pB                      �?      B     lB                   
   i: 
R:
A:      �A     �B      i
R:
A:          
      @   @             node_count             nodes     J   ��������        ����                                              ����                                 	      
   	                     ����            
                           	      
                        ����                                     conn_count              conns               node_paths              editable_instances              version             RSRC	h�7�GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ y%*5]�mG_[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bofqeljil3hrs"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 �~�i��QBq�r�[remap]

path="res://.godot/exported/133200997/export-8154ea41e6cc4381d7df5e6faf09e844-LightOverlayShaded.res"
�[remap]

path="res://.godot/exported/133200997/export-5b8bb57ec982ad2052a553f7661f1a17-StraightWaveGuide.scn"
75list=Array[Dictionary]([])
ʎbb<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
E��}��`   1�T���-0   res://Scenes/Components/Straight/Component I.png^l��qC   res://Scenes/Components/Straight/Component I_Horizontal_Overlay.png��{SG��8   res://Scenes/Components/Straight/LightOverlayShaded.tres�-�URxm<7   res://Scenes/Components/Straight/StraightWaveGuide.tscn@Jj8�x�.   res://icon.svgECFG      application/config/name         StraightPCK    application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg     dotnet/project/assembly_name         Connect A Pic Test  �? b�