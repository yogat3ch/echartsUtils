
/**
* @param {Number} n number to make into string
* @param {Number} sf significant figures of output
* @param {Boolean} add_suffix whether to add a letter suffix
* @param {String} suffix_lb The lower bound of the divisor (IE "M" do not go lower than millions)
* @param {String} magnitude If the magnitude is known apriori this can be used to override the factoring
* @returns {String} formatted axis label
*/

function num2str ({n, sf = 2, add_suffix = false, suffix_lb = "", magnitude = null}) {
      function is_null (x) {
        return x === null;
      }
      
      if (!is_null(n)) {
        var suf = ["", "K", "M", "B"];
        var out = [];
        for (var i = 0; i < suf.length; i++) {
          // test multiples of 1000
          out.push(n / (10 ** (i * 3)));
        }
        if (magnitude !== null) {
          var i = suf.indexOf(magnitude)
          var o = out[i]
        } else {
          out = out.map(Math.abs);
          // Which multiple of one thousand as the divisor results in a number above 1
          var o = Math.min(...out.filter((a) => {return a>=1;}));
          // The index of the suffix
          i = out.indexOf(o);
          // index of the lowest suffix requested
          lb = suf.indexOf(suffix_lb);
          // Replace infinity with 0
          o = isFinite(o) ? o : 0.0;
        }
        
        if (i > lb) {
          // Convert to decimal with string suffix abbreviation format
          o = (o * Math.sign(n))
          .toFixed(sf);
          // Exclude decimals from this logic that removes everything after the decimal
          if (o >= 1 || o == 0 || o <= -1) {
            o = o.replace(/[^\.]+0+$/gm, "")
            .replace(/\.$/gm, "");
          }
          if (add_suffix) {
            o = o + suf[i]; 
          } else {
            o = o.toLocaleString();
          }
        }  else {
          // otherwise just format for humans
          o = n.toLocaleString();
        }
      } else {
        var o = 'NA';
      }
  
  return o;
}
