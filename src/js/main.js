"use strict";

import React from "react";
import ReactDOM from "react-dom";

import LeftBreast from "./components/left_breast.jsx";
import List       from "./components/list.jsx";

ReactDOM.render(
  <div>
    <LeftBreast />
  </div>,
  document.getElementById("app")
);

ReactDOM.render(
  <div>
    <List />
  </div>,
  document.getElementById("out")
);