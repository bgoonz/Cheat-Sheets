// Source https://codepen.io/juliangarnier/pen/gmOwJX
// (C) Julian Garnier
// Adapted by Lilian Besson (Naereen) https://github.com/Naereen
// to add a fireworks effect on a background of a page

var canvasEl = document.querySelector('.fireworks');
var ctx = canvasEl.getContext('2d');
var numberOfParticules = 50;
var pointerX = window.innerWidth / 2;
var pointerY = window.innerHeight / 2;
var tap = ('ontouchstart' in window || navigator.msMaxTouchPoints) ? 'touchstart' : 'mousedown';
var colors = ['#FF1461', '#18FF92', '#5A87FF', '#FBF38C'];

function setCanvasSize() {
    canvasEl.width = window.innerWidth * 2;
    canvasEl.height = window.innerHeight * 2;
    canvasEl.style.width = window.innerWidth + 'px';
    canvasEl.style.height = window.innerHeight + 'px';
    canvasEl.getContext('2d').scale(2, 2);
}

function updateCoords(e) {
    pointerX = e.clientX || e.touches[0].clientX || e.pageX;
    pointerY = e.clientY || e.touches[0].clientY || e.pageY;
}

document.addEventListener('mousemove', updateCoords, false);
document.addEventListener('mouseenter', updateCoords, false);

function setParticuleDirection(p) {
    var angle = anime.random(0, 360) * Math.PI / 180;
    var value = anime.random(50, 180);
    var radius = [-1, 1][anime.random(0, 1)] * value;
    return {
        x: p.x + radius * Math.cos(angle),
        y: p.y + radius * Math.sin(angle)
    }
}

function createParticule(x, y) {
    var p = {};
    p.x = x;
    p.y = y;
    p.color = colors[anime.random(0, colors.length - 1)];
    p.radius = anime.random(16, 42);
    p.endPos = setParticuleDirection(p);
    p.draw = function() {
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.radius, 0, 2 * Math.PI, true);
        ctx.fillStyle = p.color;
        ctx.fill();
    }
    return p;
}

function createCircle(x, y) {
    var p = {};
    p.x = x;
    p.y = y;
    p.color = '#FFF';
    p.radius = 0.1;
    p.alpha = .5;
    p.lineWidth = 6;
    p.draw = function() {
        ctx.globalAlpha = p.alpha;
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.radius, 0, 2 * Math.PI, true);
        ctx.lineWidth = p.lineWidth;
        ctx.strokeStyle = p.color;
        ctx.stroke();
        ctx.globalAlpha = 1;
    }
    return p;
}

function renderParticule(anim) {
    for (var i = 0; i < anim.animatables.length; i++) {
        anim.animatables[i].target.draw();
    }
}

function animateParticules(x, y) {
    var circle = createCircle(x, y);
    var particules = [];
    for (var i = 0; i < numberOfParticules; i++) {
        particules.push(createParticule(x, y));
    }
    anime.timeline().add({
            targets: particules,
            x: function(p) { return p.endPos.x; },
            y: function(p) { return p.endPos.y; },
            radius: 0.1,
            duration: anime.random(1200, 5800),
            easing: 'easeOutExpo',
            update: renderParticule
        })
        .add({
            targets: circle,
            radius: anime.random(120, 1220),
            lineWidth: 0,
            alpha: {
                value: 0,
                easing: 'linear',
                duration: anime.random(600, 5800),
            },
            duration: anime.random(1200, 5800),
            easing: 'easeOutExpo',
            update: renderParticule,
            offset: 0
        });
}

var render = anime({
    duration: Infinity,
    update: function() {
        ctx.clearRect(0, 0, canvasEl.width, canvasEl.height);
    }
});

function fireTheFireworks(e) {
    render.play();
    if (e !== undefined) {
        updateCoords(e);
    }
    animateParticules(pointerX, pointerY);
};

// Trick to resize the canvas if needed
var centerX = window.innerWidth / 2;
var centerY = window.innerHeight / 2;

setCanvasSize();
window.addEventListener('resize', setCanvasSize, false);

window.addEventListener(tap, function(e) {
    fireTheFireworks(e)
}, false);

// Change the function, to display fireworks in case of keyboard shortcuts
$(document).ready(function() {
    Mousetrap.bind(["r", "R"], function(e) {
        console.log("Calling new version of function bound to ['r', 'R']...");
        doublereload();
        fireTheFireworks();
    });
    Mousetrap.bind(["left", "p", "P"], function(e) {
        console.log("Calling new version of function bound to ['left', 'p', 'P']...");
        prev();
        fireTheFireworks();
    });
    Mousetrap.bind(["space", "b", "B"], function(e) {
        console.log("Calling new version of function bound to ['space', 'b', 'B']...");
        playpause();
        fireTheFireworks();
    });
    Mousetrap.bind(["right", "n", "N"], function(e) {
        console.log("Calling new version of function bound to ['right', 'n', 'N']...");
        next();
        fireTheFireworks();
    });
    Mousetrap.bind(["down", "d", "D"], function(e) {
        console.log("Calling new version of function bound to ['down', 'd', 'D']...");
        volumedown();
        fireTheFireworks();
    });
    Mousetrap.bind(["up", "u", "U"], function(e) {
        console.log("Calling new version of function bound to ['up', 'u', 'U']...");
        volumeup();
        fireTheFireworks();
    });
    Mousetrap.bind(["h", "H", "?"], function(e) {
        console.log("Calling new version of[ function bound to ['h', 'H', '?']...");
        alert("Use 'p' for previous song, 'n' for next song, 'space' for pause, 'f' to toggle full screen.");
        fireTheFireworks();
    });
});
