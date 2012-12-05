$(document).ready(function() {
	$("#new_genres").tagit({
       caseSensitive: false,
       availableTags: genreTags,
       allowSpaces: true
	});
	$("#new_platforms").tagit({
       caseSensitive: false,
       availableTags: platformTags,
       allowSpaces: true
	});
	$("#new_media").tagit({
       caseSensitive: false,
       availableTags: mediumTags,
       allowSpaces: true
	});
	$("#new_modes").tagit({
       caseSensitive: false,
       availableTags: modeTags,
       allowSpaces: true
	});
	$("#new_tags").tagit({
       caseSensitive: false,
       availableTags: tagTags,
       allowSpaces: true
	});
	
});