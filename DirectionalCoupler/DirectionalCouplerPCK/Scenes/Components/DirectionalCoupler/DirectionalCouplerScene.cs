using Godot;
using MathNet.Numerics.LinearAlgebra;
using System;
using System.Collections.Generic;
using System.Numerics;

namespace DirectionalCoupler.Scenes.Components.DirectionalCoupler
{

    public partial class DirectionalCouplerScene : TextureRect
    {
        [Export] private HSlider Slider;
        [Export] public RichTextLabel Label;
        
        // Called when the node enters the scene tree for the first time.
        public override void _Ready()
        {
            Slider.ValueChanged += Slider_ValueChanged;
            UpdateSliderValue();
        }

        private void UpdateSliderValue()
        {
            Label.Text = "[center]" + Slider.Value;
        }

        private void Slider_ValueChanged(double value)
        {
            UpdateSliderValue();
            EmitSignal("SliderChanged", value);
        }

    }

}