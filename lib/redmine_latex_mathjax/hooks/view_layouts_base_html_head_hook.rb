module RedmineLatexMathjax
  module Hooks
    class ViewLayoutsBaseHtmlHeadHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})
          return "<script>
  MathJax = {
    tex: {
      inlineMath: [ ['" + MathJaxEmbedMacro.delimiterStartInline.html_safe + "','" + MathJaxEmbedMacro.delimiterEndInline.html_safe + "'], ['\\\\(', '\\\\)'] ]
    },
	startup: {
    ready: () => {
      console.log('MathJax is loaded, but not yet initialized');
      MathJax.startup.defaultReady();
      console.log('MathJax is initialized, and the initial typeset is queued');
    }
	}
  };
  //MathJax.typeset();
</script>\n" +
            javascript_include_tag(MathJaxEmbedMacro.URLToMathJax + '?config=TeX-AMS-MML_HTMLorMML&delayStartupUntil=onload') + "
<script type=\"text/javascript\">
  // Own submitPreview script with Mathjax trigger. Copy & Paste of public/javascripts/application.js
  function MJsubmitPreview(url, form, target) {
	$.ajax({
  	  url: url,
  	  type: 'post',
  	  data: $('#'+form).serialize(),
  	  success: function(data){
    	$('#'+target).html(data);
    	MathJax.typeset();
  	  }
	});
  }
  // Replace function submitPreview with own version with a Mathjax trigger
  document.addEventListener(\"DOMContentLoaded\", function() {
	a = document.getElementsByTagName(\"a\");
    for( var x=0; x < a.length; x++ ) {
      if ( a[x].onclick ) {
        str = a[x].getAttribute(\"onclick\");
        if (str.indexOf(\"submitPreview\") === 0) {
      	  a[x].setAttribute(\"onclick\", str.replace(\"submitPreview\",\"MJsubmitPreview\"));
          break;
      	};
      };  
	};	
  });
</script>"
      end
    end
  end
end
