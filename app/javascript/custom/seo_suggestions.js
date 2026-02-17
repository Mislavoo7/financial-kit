
// UPDATE DOM
function setSeoElement(newValue, $target) {
  if ($target) {
  $target.value = newValue;
  }
};

// HELPERS
function getTextContent(contentWithTags) {
  var paraDiv = document.createElement("div");
  paraDiv.innerHTML = contentWithTags;
  return paraDiv.textContent.trim().replace(/\n/g, '')
}

// CALCULATIONS
function makeSeoTitle(prefix, $sourceTitle, $targetTitle) {
  var title = $sourceTitle.value;
  if (title.length && !prefix.length) {
    var newTitle = `${title}`;
  } else if (!title.length && prefix.length) {
    var newTitle = `${prefix}`;
  } else if (title.length && prefix.length) {
    var newTitle = `${prefix} | ${title}`;
  }
  setSeoElement(newTitle.replace(/<[^>]*>?/gm, '').replace(/&nbsp/gm, ' ').replace(/;/gm, ' '), $targetTitle);
}

function makeSeoDescription($sourceDescription, $targetDescription) {
  // rm tags and truncate text to 150 char
  var description = $sourceDescription.value;
  var content = getTextContent(description);
  var newDescription = content.substring(0, 150);
  if (content.length >= 150) {
   newDescription = newDescription.slice(0, -3) +  "...";
  }
  setSeoElement(newDescription, $targetDescription);
}

function makeSeoKeywords(defaultKeywords, $sourceKeywords, $targetKeywords) {
  var keywords = [];
  if (defaultKeywords.length) keywords = defaultKeywords 

  // $sourceKeywords contains multiple large texts
  $sourceKeywords.forEach(container => {
    var text = getTextContent(container.textContent);
    var textArr = text.split(" ").filter((t) => t.length >= 4 );

    var counts = {};
    textArr.forEach(function (x) { 
      // x could be plaža, plaži, plažu, more, moru, morski
      // x short could me pla or mor
      var xShort = x.substring(0, 3).toLowerCase(); 
      counts[xShort] = (counts[xShort] || 0) + 1; 
    });

    // sortableCout is an array like => [['pla', 3], ['mor', 2] ...]
    let sortableCount = [];
    for (var key in counts) {
      sortableCount.push([key, counts[key]]);
    }
    sortableCount.sort(function(a, b) {
      return b[1] - a[1];
    });
    var top6ShortWords = sortableCount.slice(0, 6);
    var top6Keywords = [];

    // for each word in text, check each of the top6ShortWords 
    for (var i=0; i < textArr.length; i++) {
      var word = textArr[i];
      for (var j=0; j < top6ShortWords.length; j++) {
        var shortWord = top6ShortWords[j];
        // keep only alphanumeric + diacritics
        var refactoredWord = word.toLowerCase().replace(/[^a-zčćšđž]*/g, '');
        // if shortWord ('pla') is included in the text ('Evo nas na PLAži') ...
        if (refactoredWord.includes(shortWord[0])) {
          // and if the shortWord ('pla') is not present in top6keywords ...
          if (!top6Keywords.map((w) => w.substring(0, 3)).includes(shortWord[0]) ) { 
            // add the word  as new keywords
            top6Keywords.push(refactoredWord)
          }
        }
      }
    }

    // add to main keywords
    for (var i=0; i<top6Keywords.length; i++) {
      var topKeyword = top6Keywords[i];
      if (!keywords.includes(topKeyword)) keywords.push(topKeyword)
    }
  })

  var newKeywords = keywords.join(", ");
  setSeoElement(newKeywords, $targetKeywords);
}

// RUN
window.seoSuggestion = (opt) => {
  // get source fields
  var source = opt.source;
  var $sourceTitle = document.querySelector(`.${source.titleClassName}`);
  var $sourceDescription = document.querySelector(`.${source.descriptionClassName}`);
  var $sourceKeywords = document.querySelectorAll(`.${source.keywordsClassName}`);

  // get seo target fields
  var target = opt.target;
  var $targetTitle = document.querySelector(`.${target.titleClassName}`);
  var $targetDescription = document.querySelector(`.${target.descriptionClassName}`);
  var $targetKeywords = document.querySelector(`.${target.keywordsClassName}`);

  // get default
  var titlePrefix = opt.titlePrefix;
  var defaultKeywords = opt.defaultKeywords;

  // calculations
  makeSeoTitle(titlePrefix, $sourceTitle, $targetTitle);
  makeSeoDescription($sourceDescription, $targetDescription);
  makeSeoKeywords(defaultKeywords, $sourceKeywords, $targetKeywords);
}
