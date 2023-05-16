const l = console.log;
const cardDeck = {
  suits: ["♡", "♤", "♣", "♦"],
  courts: ["J", "Q", "K", "A"],
  [Symbol.iterator]: function* () {
    for (let suit of this.suits) {
      for (let i = 2; i <= 10; i++) yield suit + i;
      for (let c of this.courts) yield suit + c;
    }
  },
};

// l([...cardDeck]);

const InfinityAndBeyond = function* () {
  let i = 1;
  while (true) {
    yield i++;
  }
};

const take = function* (n, iterable) {
  const result = [];
  for (let e of iterable) {
    if (n <= 0) return;
    n--;
    yield e;
  }
};
// l([...take(5, InfinityAndBeyond())]);

const xmap = function* (iterable, f) {
  for (let e of iterable) {
    yield f(e);
  }
};
// let it = map(InfinityAndBeyond(), (i) => i * i);
// l([...take(9, it)]);

const filter = function* (iterable, f) {
  for (let e of iterable) {
    if (f(e)) yield e;
  }
};

const reduce = function (iterable, f, initial) {
  let result = initial;
  for (let e of iterable) {
    result = f(result, e);
  }
  return result;
};

const range = function* (start, end) {
  for (let i = start; i <= end; i++) {
    yield i;
  }
};

// ======================== Stackoverflow Work-around ========================
function ping(n) {
  l("ping", n);
  return pong(n + 1);
}
function pong(n) {
  l("pong", n);
  return ping(n + 1);
}
// ping(0);

let players = {};
let queue = [];

function send(player, msg) {
  queue.push([player, msg]);
}
function run() {
  while (queue.length) {
    let [player, msg] = queue.shift();
    players[player].next(msg);
  }
}

function* xping() {
  let n;
  while (true) {
    n = yield;
    l(n);
    send("xpong", ++n);
  }
}
function* xpong() {
  let n;
  while (true) {
    n = yield;
    l(n);
    send("xping", ++n);
  }
}

// players.xping = xping();
// players.xpong = xpong();
// send("xping", 'get ready to ping');
// send("xpong", 'get ready to pong');
// send("xping", '0');
// run()
// ======================== Recursion vs Iteration ========================

function sum(nums) {
  return nums.length === 0 ? 0 : nums[0] + sum(nums.slice(1));
}
l(sum([1, 2, 3, 4, 5]));

function fibonacci(n, memo = {}) {
  if (n===0) return 0;
  if (n===1) return 1;
  
  if (memo[n]) return memo[n];
  return (memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo));
}
l(fibonacci(1476));

function map(fn, arr) {
  return arr.length === 0 ? [] : [fn(arr[0]), ...map(fn, arr.slice(1))];
}
l(map((x) => x * x, [1, 2, 3, 4, 5]));