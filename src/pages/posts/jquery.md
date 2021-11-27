---
title: jQuery
subtitle: jQuery Cheat Sheet
excerpt: >-
  A Node.js app runs in a single process, without creating a new thread for every request. Node.js provides a set of asynchronous I/O primitives in its standard library that prevent JavaScript code from blocking and generally, libraries in Node.js are written using non-blocking paradigms, making blocking behavior the exception rather than the norm.
date: '2021-11-21'
thumb_img_path: images/3.jpg
thumb_img_alt: jQuery
content_img_path: images/3.jpg
content_img_alt: jQuery
seo:
  title: jQuery
  description: A Node.js app runs in a single process, without creating a new thread for every request. Node.js provides a set of asynchronous I/O primitives in its standard library that prevent JavaScript code from blocking and generally, libraries in Node.js are written using non-blocking paradigms, making blocking behavior the exception rather than the norm.
  extra:
    - name: 'og:type'
      value: article
      keyName: property
    - name: 'og:title'
      value: jQuery
      keyName: property
    - name: 'og:description'
      value: jQuery Cheat Sheet
      keyName: property
    - name: 'og:image'
      value: images/3.jpg
      keyName: property
      relativeUrl: true
    - name: 'twitter:card'
      value: summary_large_image
    - name: 'twitter:title'
      value: jQuery
    - name: 'twitter:description'
      value: jQuery Cheat Sheet
    - name: 'twitter:image'
      value: images/3.jpg
      relativeUrl: true
template: post
---




### jQuery streamlines dynamic behavior

*jQuery* is a JavaScript library that streamlines the creation of dynamic behavior with predefined methods for selecting and manipulating DOM elements. It offers a simplified approach to implementing responsiveness and requires fewer lines of code to assign behaviors to DOM elements than traditional JavaScript methods.

```js
//Selecting DOM elements and adding an event listener in JS
const menu = document.getElementById('menu');
const closeMenuButton = document.getElementById('close-menu-button');
closeMenuButton.addEventListener('click', () => {
    menu.style.display = 'none';
});
 
//Selecting DOM elements and adding an event listener in jQuery
$('#close-menu-button').on('click', () =>{
  $('#menu').hide();  
});
```

### jQuery document ready

JavaScript code runs as soon as its file is loaded into the browser. If this happens before the DOM (Document Object Model) is fully loaded, unexpected issues or unpredictable behaviors can result.

jQuery's `.ready()` method waits until the DOM is fully rendered, at which point it invokes the specified callback function.

```js

$(document).ready(function() {
  // This code only runs after the DOM is loaded.
  alert('DOM fully loaded!');
});
```

### jquery object variables start with

*jQuery objects* are typically stored in variables where the variable name begins with a `$` symbol. This naming convention makes it easier to identify which variables are jQuery objects as opposed to other JavaScript objects or values.

```js

//A variable representing a jQuery object
const $myButton = $('#my-button');
```

### jQuery CDN Import

*jQuery* is typically imported from a CDN (Content Delivery Network) and added at the bottom of an HTML document in a `<script>` tag before the closing `</body>` tag.

The jQuery `<script>` tag must be listed before linking to any other JavaScript file that uses the jQuery library.

```html

<html>
  <head></head>
  <body>
    <!-- HTML code -->
    
    <!--The jQuery library-->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
 
    <!--Site-specific JavaScript code using jQuery-->
    <script src="script.js"></script>
  </body>
</html>
```

---
### jquery fadeIn effect method

The jQuery `.fadeIn()` effect method causes a hidden element to gradually appear on the page. The method takes *optional* parameters.

The first optional parameter specifies the duration of the fading effect. The default value is 400 milliseconds.

The second parameter specifies the name of an "easing" function that determines the speed of the fading effect at different points in the animation. The default value is 'swing', where the fade-in effect is slower at the beginning/end and faster in the middle.

```js

// The '#menu' element will gradually appear 
// on the page when the '#menu-button' is clicked.
$('#menu-button').on('click', () => {
  // equivalent to $('#menu').fadeIn(400, 'swing')
  $('#menu').fadeIn();
});
```

### jquery fadeOut effect method

The jQuery `.fadeOut()` effect method causes an element and the space it was occupying to gradually disappear from the page. The method takes *optional* parameters.

The first optional parameter specifies the duration of the fading effect. The default value is 400 milliseconds.

The second parameter specifies an "easing" function that determines the speed of the fading effect at different points in the animation. The default value is 'swing', where the fade-out effect is slower at the beginning/end and faster in the middle.

```js

// The '#menu' element will gradually disappear from 
// the page when the '#menu-button' is clicked.
$('#menu-button').on('click', () => {
  // equivalent to $('#menu').fadeOut(400, 'swing')
  $('#menu').fadeOut();
});

```

### jquery slideToggle method

The jQuery `.slideToggle()` effect method combines the effects of the `.slideDown()` and `.slideUp()` methods. This causes the element to alternate between gradually appearing by sliding down and gradually disappearing by sliding up every time the event listener is triggered.

The `.slideToggle()` method takes an optional parameter that specifies the duration of the effect. If not specified, the default value is 400 milliseconds.

```js

// The '#menu' element will alternate between 
// gradually sliding down and gradually sliding up 
// every time the '#menu-button' is clicked.
$('#menu-button').on('click', () => {
  $('#menu').slideToggle();
});

```

### jquery show effect

The jQuery `.show()` effect method causes an element, assuming it is hidden, to instantly appear on the page.

```js


//Instantly reveals the '#menu' element when the '#show-menu-button' is clicked.
$('#show-menu-button').on('click', () => {
  $('#menu').show();
});

```

### jquery toggle effect

The jQuery `.toggle()` effect method combines the effects of the `.hide()` and `.show()` methods. Every time the event listener is triggered, the element will alternate between displayed on the page and hidden from the page.

```js

//The '#menu' element will alternate between being displayed and hidden every time the '#menu-button' is clicked. 
$('#menu-button').on('click', () =>{
  $('#menu').toggle(); 
});

```

### jquery effects

*jQuery Effects* are jQuery object methods used to add animation and dynamic behavior to page elements. Effects can be used to show or hide elements, fade elements in and out, and more.

```js


// The .show() effect causes the #menu element to 
// appear once the #menu-button element is clicked. 
$('#menu-button').on('click', event => {
  $('#menu').show();  
});

```

### jquery fadeToggle method

The jQuery `.fadeToggle()` effect method combines the effects of the `.fadeIn()` and `.fadeOut()` methods. The element will alternate between gradually disappearing and appearing every time the event listener is triggered. This method takes optional parameters.

The first optional parameter specifies the duration of the fading effect. The default value is 400 milliseconds.

The second parameter specifies the name of an "easing" function that determines the speed of the fading effect at different points in the animation. The default value is 'swing', where the fading effect is slower at the beginning/end and faster in the middle.

```js


// The '#menu' element will alternate between 
// gradually disappearing and gradually appearing 
// on the page when the '#menu-button' is clicked.
$('#menu-button').on('click', () => {
  // equivalent to $('#menu').fadeToggle(400, 'swing')
  $('#menu').fadeToggle();
});

```

### jquery slideUp method

The jQuery `.slideUp()` effect method causes an element and the space it was occupying to gradually disappear from the page by sliding up its content.

This method takes an optional parameter that specifies the duration of the effect in milliseconds. If not specified, the default duration is 400 milliseconds.

```js


// The '#menu' element will gradually disappear 
// from the page by sliding up its content when 
// the '#menu-button' is clicked.
$('#menu-button').on('click', () => {
  // slide up over half a second
  $('#menu').slideUp(500);
});

```

### jquery hide effect

The jQuery `.hide()` effect method causes an element and the space it was occupying to disappear instantly from the page. When executed, the browser will render the HTML as if the hidden element does not exist.

```js

//The '#menu' element will disappear instantly from the page when the '#hide-menu-button' is clicked. 
$('#hide-menu-button').on('click', () => {
  $('#menu').hide();  
});

```

### jquery slideDown method

The jQuery `.slideDown()` effect method causes a hidden element to gradually appear on the page by sliding down its content.

This method takes an optional parameter that specifies the duration of the effect in milliseconds. If not specified, the default value of 400 milliseconds is used.

```js

// The '#menu' element will gradually appear on 
// the page by sliding down its content when the 
// '#menu-button' element is clicked.
$('#menu-button').on('click', () => {
  // menu appears over 400ms duration
  $('#menu').slideDown();
});

```

---






## Jquery Cheat Sheet:

```js

///////////////////////////////////
// 1. Selectors

// Selectors in jQuery are used to select an element
let  page = $(window); // Selects the whole viewport

// Selectors can also be CSS selector
let  paragraph = $('p'); // Selects all paragraph elements
let  table1 = $('#table1'); // Selects element with id 'table1'
let  squares = $('.square'); // Selects all elements with the class 'square'
let  square_p = $('p.square') // Selects paragraphs with the 'square' class


///////////////////////////////////
// 2. Events and Effects
// jQuery is very good at handling what happens when an event is triggered
// A very common event used is the ready event on the document
// You can use the 'ready' method to wait until the element has finished loading
$(document).ready(function(){
  // Code won't execute until the document is loaded
});
// You can also use defined functions
function onAction() {
  // This is executed when the event is triggered
}
$('#btn').click(onAction); // Invokes onAction on click

// Some other common events are:
$('#btn').dblclick(onAction); // Double click
$('#btn').hover(onAction); // Hovering over
$('#btn').focus(onAction); // On focus
$('#btn').blur(onAction); // Losses focus
$('#btn').submit(onAction); // On submit
$('#btn').select(onAction); // When an element is selected
$('#btn').keydown(onAction); // When a key is pushed down
$('#btn').keyup(onAction); // When a key is released
$('#btn').keypress(onAction); // When a key is pressed
$('#btn').mousemove(onAction); // When the mouse is moved
$('#btn').mouseenter(onAction); // Mouse enters the element
$('#btn').mouseleave(onAction); // Mouse leaves the element


// These can all also trigger the event instead of handling it
// by simply not giving any parameters
$('#btn').dblclick(); // Fires double click on the element

// You can handle multiple events while only using the selector once
$('#btn').on(
  {dblclick: myFunction1} // Triggered on double click
  {blur: myFunction1} // Triggered on blur
);

// You can move and hide elements with some effect methods
$('.table').hide(); // Hides the element(s)

// Note: calling a function in these methods will still hide the element
$('.table').hide(function(){
    // Element hidden then function executed
});

// You can store selectors in let iables
let  tables = $('.table');

// Some basic document manipulation methods are:
tables.hide(); // Hides element(s)
tables.show(); // Shows (un-hides) element(s)
tables.toggle(); // Changes the hide/show state
tables.fadeOut(); // Fades out
tables.fadeIn(); // Fades in
tables.fadeToggle(); // Fades in or out
tables.fadeTo(0.5); // Fades to an opacity (between 0 and 1)
tables.slideUp(); // Slides up
tables.slideDown(); // Slides down
tables.slideToggle(); // Slides up or down

// All of the above take a speed (milliseconds) and callback function
tables.hide(1000, myFunction); // 1 second hide animation then function

// fadeTo has a required opacity as its second parameter
tables.fadeTo(2000, 0.1, myFunction); // 2 sec. fade to 0.1 opacity then function

// You can get slightly more advanced with the animate method
tables.animate({margin-top:"+=50", height: "100px"}, 500, myFunction);
// The animate method takes an object of css and values to end with,
// optional options parameter to tune the animation,
// and of course the callback function

///////////////////////////////////
// 3. Manipulation

// These are similar to effects but can do more
$('div').addClass('taming-slim-20'); // Adds class taming-slim-20 to all div

// Common manipulation methods
$('p').append('Hello world'); // Adds to end of element
$('p').attr('class'); // Gets attribute
$('p').attr('class', 'content'); // Sets attribute
$('p').hasClass('taming-slim-20'); // Returns true if it has the class
$('p').height(); // Gets height of element or sets height


// For many manipulation methods, getting info on an element
// will ONLY get the first matching element
$('p').height(); // Gets only the first 'p' tag's height

// You can use each to loop through all the elements
let  heights = [];
$('p').each(function() {
  heights.push($(this).height()); // Adds all 'p' tag heights to array
});

```



## Basics

Introduction to jQuery programming

#### Include

[Download](https://code.jquery.com/)

<script src\="https://code.jquery.com/jquery-latest.min.js" type\="text/javascript"\></script\>

<script src\="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"\></script\>

#### Syntax

$(document).ready(function(){
$(".demo").click(function(){
$(this).hide(200);
});
});

$(function(){

});

#### Each

$(".demo").each(function() {                
document.write($(this).text() + "\\n");  
});

#### Trigger

$("a#mylink").trigger("click"); 

#### noConflict

var jq \= $.noConflict();            
jq(document).ready(function(){
jq("#demo").text("Hello World!");
});

## Selectors

Selectors to target elements. Similar to CSS.

$("\*")                      
$("p.demo")                 
$("p:first")                
$("p span")                 
$("p > span")               
$("p + span")               
$("p ~ span")               
$("ul li:first")            
$("ul li:first-child")      
$("ul li:nth-child(3)")     
$("\[href\]")                 
$("a\[target='\_blank'\]")     
$("a\[target!='\_blank'\]")    
$(":input")                 
$(":button")                
$("tr:even")                
$("tr:odd")                 
$("span:parent")            
$("span:contains('demo')")  

#### Actions

**$(selector).action()**

$(this).hide()      
$("div").hide()     
$(".demo").hide()   
$("#demo").hide()   

## Events

Trigger jQuery events

$(".demo").click(function(){
$(this).hide(200);
});

#### Mouse

scroll, click, dblclick, mousedown, mouseup, mousemove, mouseover, mouseout, mouseenter, mouseleave, load, resize, scroll, unload, error

#### Keyboard

keydown, keypress, keyup

#### Form

submit, change, focus, blur

#### DOM Element

blur, focus, focusin, focusout, change, select, submit

#### Browser

load, resize, scroll, unload, error

#### .bind()

$(document).ready(function() {              
$("#demo").bind('blur', function(e) {

});
});

## Ads

We show ads to support this free website.

## Effects

Animation effects

#### Hide / Show

$("#demo").hide();      
$("#demo").show(200);   
$("#demo").toggle();    

$( "#element" ).hide( "slow", function() {  
console.log( "Animation complete." );
});

#### Fade

fadeIn, fadeOut, fadeToggle, fadeTo

$("#demo").fadeIn();                
$("#demo").fadeOut(300);            
$("#demo").fadeToggle("slow");      
$("#demo").fadeTo("slow", 0.25);    

#### Slide

slideDown, slideUp, slideToggle

$("#demo").slideDown();
$("#demo").slideUp("slow");
$("#demo").slideToggle();

#### Animate

$(selector).animate({params},speed,callback);

$("div").animate({
opacity: '0.5',
left: '200px',
height: '200px'
});

#### stop() Method

$("#demo").stop();

$('#demo').mouseleave(function(event) {     
$('.tab').stop().animate({              
opacity : '0.5',
marginTop: '10px'
}, 500, function() {                    
$('#demo').removeClass('hovered');  
});
});
$('#demo').mouseover(function(event) {      
$('.tab').stop().animate({              
opacity : '1',
marginTop: '0px'
}, 300, function() {                    
$('#demo').addClass('hovered');     
});
});

#### Chaining

$("#demo").css("backgroundColor", "green").slideUp(500).slideDown(500);

## DOM Manipulation

Accessing and manipulating the Document Object Model

#### Content

$("#demo").text();                  
$("#demo").html();                  
$("#demo").val();                   
$("#demo").html('Hey <em>yo</em>'); 

#### Attributes

$("#link").attr("href");                    
$("#link").attr("href",'https://htmlg.com'); 
$("#link").attr({
"href" : "https://htmlg.com",            
"title" : "HTML Editor"
});
$("#link").attr("href", function(i, origValue){
return origValue + "/help";             
});

#### Add

$(".demo").prepend("Yo!");          
$(".demo").append("<em>Hey!</em>"); 
$(".demo").before("Cheers");        
$(".demo").after("<em>Peace</em>"); 

#### Remove

$("#demo").remove();            
$("#demo").empty();             
$("div").remove(".cl1, .cl2");  

#### Classes

$("#demo").addClass("big red"); 
$("h1, p").removeClass("red");  
$("#demo").toggleClass("big");  

#### CSS

$("#demo").css("background-color");     
$("#demo").css("color", "blue");        
$("#demo").css({"color": "blue", "font-size": "20px"}); 

#### Dimensions

width, height, innerWidth, innerHeight, outerWidth, outerHeight  
_**inner** - includes padding  
**outer** - includes padding and border_

## Traversing

Select elements based on their relation to other elements.

$("#demo").parent();                
$("span").parent().hide();          
$("#demo").parents();               
$("#demo").parentsUntil("#demo2");  
$("#demo").children();              
$("#demo").children(".first");      
$("#demo").find("span");            
$("#demo").find("\*");               
$("#demo").siblings("span");        
$("#demo").next();                  
$("p").nextAll();                   
$("#demo").nextUntil("#demo2");     
$("#demo").prev();                  
$("p").prevAll();                   
$("#demo").prevUntil("#demo2");     

#### Filtering

$("span strong").first();   
$("span strong").last();    
$("div").eq(9);             
$("div").filter(".big");    
$("div").not(".big");       

## Ads

We show ads to support this free website.

## Ajax

Exchanging data with the server dynamically updating parts of the page.

$("#demo").load("file.txt h1.main");                                
$("#demo").load("file.txt", function(responseTxt, statusTxt, xhr){  
if(statusTxt \== "success") {
document.write("Content loaded successfully!"); 
} else {
document.write("Error: " + xhr.status + ": " + xhr.statusText); 
}
});

#### $.get()

$.get("demo.asp", function(data, status){       
document.write("Data: " + data + "\\nStatus: " + status);
});

#### $.post()

$.post("demo.asp",      
{
name: "John",       
age: 30
},
function(data, status){ 
console.log("Data: " + data + "\\nStatus: " + status);
});
