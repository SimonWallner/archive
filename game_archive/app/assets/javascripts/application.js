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
//= require notification.js
//= require videoembed.js

$(document).ready(function() {
    $("textarea").parent().append(
         '<img style="width: 32px; height: 32px;" class="full_markdown_help" alt="Help" src="/assets/help.png" title="' +
                '<dl>\n' +
                '<dt>PARAGRAPHS and LINE BREAKS</dt>\n' +
                '<dd>A paragraph is simply one or more consecutive lines of text, separated by one or more blank lines.</br>\n' +
                'When you do want to insert a <br /> break tag using Markdown, you end a line with two or more spaces, then type return.</dd>\n' +

                '<dt>HEADERS</dt>\n' +
                '<dd># This is an H1</br>\n' +
                '###### This is an H6</dd>\n' +

                '<dt>BLOCKQUOTES</dt>\n' +
                '<dd>Email-style > characters genereate blockquotes. It looks best if you hard wrap the text and put a > before every line:</br>\n' +
                '> This is a blockquote.</br>\n' +
                '> > This is nested blockquote.</br>\n' +
                '> Back to the first level.</dd>\n' +

                '<dt>LISTS</dt>\n' +
                '<dd>Unordered lists use *, +, - and ordered lists use numbers folloewed by periods:</br>\n' +
                '*   Red</br>\n' +
                '1.  Bird</dd>\n' +

                '<dt>CODE BLOCKS and INLINE CODE</dt> \n' +
                '<dd>To produce a code block, simply indent every line of the block by at least 4 spaces or 1 tab. To indicate inline code, wrap it with backtick quotes (`). </br>\n' +
                '    This is a code block.</br> \n' +
                'Use the `printf()` function.</dd> \n' +

                '<dt>HORIZONTAL RULES</dt>\n' +
                '<dd>You can produce a horizontal rule tag by placing three or more hyphens ---, asterisks ***, or underscores ___ on a line by themselves</dd>\n' +

                '<dt>LINKS</dt>\n' +
                '<dd>This is [an example](http://example.com/ &quot;Title&quot;) inline link.</br>\n' +
                'To reference on a game, developer or company use the @ symbol followed by the starting of the searched name.</dd>\n' +

                '<dt>EMPHASIS and STRONG</dt>\n' +
                '<dd>Asterisks (*) and underscores (_) are indicators of emphasis. Double *’s or _’s will be displayed bold.</br>\n' +
                '<em>*emphasis*</em> <em>_emphasis_</em> <strong>**strong**</strong> <strong>__strong__</strong></dd>\n' +
                '</dl>' +
          '">'
    );
    $(".full_markdown_help").tooltipsy();
});





