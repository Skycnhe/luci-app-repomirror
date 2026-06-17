'use strict';
'require view';
'require form';
'require uci';

return view.extend({
	load: function() {
		return uci.load('repomirror');
	},

	render: function() {
		var m, s, o;

		m = new form.Map('repomirror', _('Repo Mirror Switcher'),
			_('Modify /etc/apk/repositories.d/distfeeds.list to switch to Chinese mirror sources.'));

		s = m.section(form.TypedSection, 'repomirror', _('Settings'));
		s.anonymous = true;

		o = s.option(form.Flag, 'enabled', _('Enable'));
		o.rmempty = false;

		o = s.option(form.ListValue, 'mirror', _('Select Mirror'));
		o.value('tsinghua', _('Tsinghua University (TUNA)'));
		o.value('ustc', _('USTC'));
		o.value('aliyun', _('AliCloud'));
		o.value('tencent', _('Tencent Cloud'));
		o.default = 'tsinghua';

		return m.render();
	}
});
