var UrMathJax = (function() {

    var buffers = {};
    var lastTexts = {};

    var compareAndSetLastText = function (id, newText) {
	var lastText = lastTexts[id];
	if (lastText == newText)
	    return false;
	
	lastTexts[id] = newText;
	return true;
    }
    
    var getOrGenerateBuffer = function (id) {
	var buff = buffers[id];
	if (!buff) {
	    buff = document.createElement('div');
	    buffers[id] = buff;
	}
	return buff;
    };

    var cb = {    
	done : function (id) {
	    document.getElementById(id).innerHTML = getOrGenerateBuffer(id).innerHTML;
	}
    };

    var isReady = false;
    var pending = [];

    var typeset = null;
    var typesetContent = null;
    
    typeset = function (_, id) {
	if (!isReady) {
	    pending.push(function(){ typeset(_, id); });
	    return;
	}
	var elem = document.getElementById(id);
	
	MathJax.Hub.Queue(["Typeset", MathJax.Hub, elem]);
    };
    
    typesetContent = function (_, text, id) {
	if (!isReady) {
	    pending.push(function(){ typesetContent(_, text, id); });
	    return;
	}
	var buffer = getOrGenerateBuffer(id);

	if (compareAndSetLastText(text, id)) {
	    buffer.innerHTML = text;	
	    MathJax.Hub.Queue(["Typeset", MathJax.Hub, buffer], ["done", cb, id] );
	}
    };

    return {
	execOnLoadCbs: function() {
	    if(!isReady) {
		isReady = true;
		while (pending.length > 0) {
		    var elem = pending.shift();
		    if (elem) elem();
		}
	    }
	},
	
	loadMathJax : function () {
	    var conf = document.createElement('script');
	    conf.setAttribute('type', "text/x-mathjax-config");
	    conf.innerHTML = "MathJax.Hub.Config({ " +
		"extensions: [\"tex2jax.js\"], " +
		"jax: [\"input/TeX\",\"output/HTML-CSS\"]," +
		"tex2jax: {inlineMath: [[\"$\",\"$\"],[\"\\\\(\",\"\\\\)\"]]} });" +
		"MathJax.Hub.Register.StartupHook(\"onLoad\", function() { UrMathJax.execOnLoadCbs(); });";

	    var scrp = document.createElement('script');
	    scrp.setAttribute('type', "text/javascript");
	    scrp.src = '/MathJax/MathJax.js';
	    //scrp.src = '/MathJax/MathJax.js?config=TeX-AMS_HTML-full';
	    document.head.append(conf);
	    document.head.append(scrp);
	    
	    return this;
	},
	
	typesetMathJax: typeset,

	typesetContentMathJax: typesetContent

    };
})();
