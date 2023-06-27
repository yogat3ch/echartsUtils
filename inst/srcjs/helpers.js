
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
        
