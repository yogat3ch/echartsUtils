
function is_likely_perc(x) {
  return x < 1.01 && x > -1.01;
}


function is_null (x) {
  return x === null | x === undefined;
}


/** Adds a purrr::keep style function to Object. Useful for filtering `params` objects in tooltip callbacks
/* @param {Object} obj  object to be filtered
/* @param {Function} predicate  Function to be applied to each sub-object to determine if it should be kept
/* @return {Object} with only the sub-objects matching the predicate function remaining
**/
Object.keep = (obj, predicate) =>
    Object.keys(obj)
          .filter( key => predicate(obj[key]) )
          .reduce( (res, key) => (res[key] = obj[key], res), {} );


/**
 * Generate a sequence of numbers
 * @param {Number} start
 * @param {Number} end
 * @returns {Array} with sequence from start to end
 */
function seq(start, end) {
  return Array(end - start + 1).fill().map((_, idx) => start + idx)
}

/**
 * @param  {String} selector
 * @returns  {Logical}
 */
function isVisible(selector) {
  return $(selector).is(":visible");
}

/**
 * @param selector {String} selector
 * @usage waitForEl('.some-class').then((elm) => {
    console.log('Element is ready');
    console.log(elm.textContent);
});
* @credit https://stackoverflow.com/a/61511955
 */
function waitForEl(selector) {
    return new Promise(resolve => {
        if (document.querySelector(selector)) {
            return resolve(document.querySelector(selector));
        }

        const observer = new MutationObserver(mutations => {
            if (document.querySelector(selector)) {
                resolve(document.querySelector(selector));
                observer.disconnect();
            }
        });

        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    });
}
