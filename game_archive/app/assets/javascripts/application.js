// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery.min
//= require jquery-ui.min
//= require jquery_ujs
//= require tag-it.js
//= require tooltipsy.min.js
//= require at_autocomplete.js
//= require jquery.form.js
//= require notification.js
//= require videoembed.js
//= require general_functions.js
//= require screenshot.js

var help =
     {'defunct' :
          ': <span class="field-help">Date the studio/organisation became defunct and an optional reason (e.g. merged with XY, ...)',
     'founded' :
         ': <span class="field-help">Founding date of this studio/organisation.</span>',
     'official name' :
         ': <span class="field-help">Official name of the studio/organisation.</span>',
     'locations' :
         ': <span class="field-help">Comma separated list of locations where this studio/organisation is or has been active.</span>',
     'userdefined' :
          ': <span class="field-help">Userdefined field to add additional categories and data that does not match any of the other fields.</span>',
     'external links' :
         ': <span class="field-help">Links to external websites using the simplified markup syntax. <span class="code">[description](http://example.com)</span>',
     'developer' :
         ': <span class="field-help">Developers that contributed to this game. Add a developer\'s name and and optional role (e.g. Artist, Lead Programmer, ...). If the developer is found in the databse the field turns green.</span>',
     'publisher' :
         ': <span class="field-help">Publishers of the game and additional optional information (e.g. publishing platform, region, ...).</span>',
     'distributor' :
          ': <span class="field-help">Distributors of the game and additional optional information (e.g. distribution medium, region, ...).</span>',
     'credits' :
         ': <span class="field-help">Additional credits with optional information (e.g. localisation, marketing, testing, ...).</span>',
     'release dates' :
         ': <span class="field-help">Release dates with additional optional information (e.g. platform, region, ...).</span>',
     'series' :
         ': <span class="field-help">Prequels/sequels or other games in a series with additional optional information (e.g. prequel, sequel, spin-off, ...).</span>',
     'review scores' :
         ': <span class="field-help">Individual review scores. Please also link to the review <span class="code">[description](http://example.com)</span></span>',
     'aggregate scores' :
         ': <span class="field-help">Aggregated review scores. Please also link to the score aggregator <span class="code">[description](http://example.com)</span></span>'
};

// $(document).ready(function() {
//     $("textarea[id*='_description']").parent().append( help.full );
//     $(".newhelp").tooltipsy({delay: 600}).removeClass("newhelp");
//     $(".all").hide();
// });
