function sum() {
  let total = 0;
  for (let i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }

  return total;
}

// console.log(sum(1,2,43));

function betterSum(...nums) {
  let total = 0;
  nums.forEach( function(el) {
    total += el;
  });
  return total;
}

// console.log(betterSum(1,2,43));

Function.prototype.worseMyBind = function() {
  let obj = arguments[0];
  let args = Array.prototype.slice.call(arguments, 1);
  let that = this;
  return function () {
    that.apply(obj, args.concat(Array.prototype.slice.call(arguments)));
  };
};

Function.prototype.myBind = function(object, ...args) {
  return (...otherArgs) => this.apply(object, args.concat(otherArgs));
};
//
// class Cat {
//   constructor(name) {
//     this.name = name;
//   }
//
//   says(sound, person) {
//     console.log(`${this.name} says ${sound} to ${person}!`);
//     return true;
//   }
// }
//
// const markov = new Cat("Markov");
// const breakfast = new Cat("Breakfast");
//
// markov.says("meow", "Ned");
// // Markov says meow to Ned!
// // true
//
// // bind time args are "meow" and "Kush", no call time args
// markov.says.myBind(breakfast, "meow", "Kush")();
// // Breakfast says meow to Kush!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// markov.says.myBind(breakfast)("meow", "a tree");
// // Breakfast says meow to a tree!
// // true
//
// // bind time arg is "meow", call time arg is "Markov"
// markov.says.myBind(breakfast, "meow")("Markov");
// // Breakfast says meow to Markov!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// const notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow", "me");
// // Breakfast says meow to me!
// // true

function curriedSum (numArgs) {
  let numbers = [];
  function _curriedSum (num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      let total = 0;
      numbers.forEach( function (el) {
        total += el;
      });
      return total;
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}

let a = curriedSum(3);

// console.log(a(3)(10)(20));

Function.prototype.applyCurry = function (numArgs) {
  let args = [];
  let that = this;

  function _curry (arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return that.apply(that, args);
    } else {
      return _curry;
    }
  }
  return _curry;
};

Function.prototype.curry = function (numArgs) {
  let args = [];
  let that = this;
  function _curry (arg) {
    args.push(arg);
    if (args.length === numArgs){
      return that(...args);
    } else {
      return _curry;
    }
  }
  return _curry;
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

let currySumThree = sumThree.applyCurry(3);
console.log(currySumThree(1)(2)(3));
