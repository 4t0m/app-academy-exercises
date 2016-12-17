Function.prototype.inherits = function (parent) {
  let Surrogate = function (){};
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate ();
  this.prototype.constructor = this;
};


function MovingObject () {}

MovingObject.prototype.vroom = function () {
  console.log("Vroooom");
};


function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);

let ship = new Ship();
ship.vroom();
