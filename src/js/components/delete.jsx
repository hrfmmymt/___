"use strict";

import React from "react";
import request from "superagent";

export default class DeleteButton extends React.Component {
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(e) {
    const el = e.target.parentNode;
    if(confirm("delete?")) {
      request.post("/delete")
        .send({id: el.getAttribute("data-id")})
        .type("form")
        .end( (err, res) => {
          if(err) {
            console.log("error");
          } else {
            el.parentNode.removeChild(el);
          }
        })
    }
  }

  render() {
    return (
      <button
        type="button"
        className="form__button form__button__delete"
        onClick={this.handleClick}
      >
        delete
      </button>
    );
  }
}