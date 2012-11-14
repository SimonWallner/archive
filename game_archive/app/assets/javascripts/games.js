$(document).ready(function() {
	$("#new_genres").tagit({
       caseSensitive: false,
       availableTags: genreTags,
       allowSpaces: true
	});
});