"use strict";

import React from "react";
import ReactDOM from "react-dom";

import LeftBreast from "./components/left_breast.jsx";
import RightBreast from "./components/right_breast.jsx";
import BabyBottle from "./components/baby_bottle.jsx";
import List       from "./components/list.jsx";

ReactDOM.render(
  <div>
    <LeftBreast />
    <RightBreast />
  </div>,
  document.getElementById("breast")
);

ReactDOM.render(
  <div>
    <BabyBottle />
  </div>,
  document.getElementById("bottle")
);

ReactDOM.render(
  <div>
    <List />
  </div>,
  document.getElementById("out")
);