if (!RedactorPlugins) var RedactorPlugins = {};

(function($)
{
	RedactorPlugins.textdirection = function()
	{
		return {
			init: function()
			{
				var that = this;
				var dropdown = {};

				dropdown.ltr = { title: this.lang.get('left_to_right'), func: that.textdirection.setLtr };
				dropdown.rtl = { title: this.lang.get('right_to_left'), func: that.textdirection.setRtl};

				var button = this.button.add('textdirection', this.lang.get('textdirection'));
				this.button.addDropdown(button, dropdown);
			},
			setRtl: function()
			{
				this.buffer.set();
				this.block.setAttr('dir', 'rtl');
			},
			setLtr: function()
			{
				this.buffer.set();
				this.block.removeAttr('dir');
			}
		};
	};
})(jQuery);