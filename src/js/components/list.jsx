"use strict";

import React from "react";
import request from "superagent";

import DeleteButton from "./delete.jsx";

export default class List extends React.Component {
  constructor() {
    super();
    this.state = ({
      lists: []
    });
  }

  componentDidMount() {
    this.serverRequest =
      request.get("/works.json")
      .end( (err, res) => {
        const json = JSON.parse(res.text);
        this.setState({
          lists: json
        });
      });
  }

  componentWillUnmount() {
    this.serverRequest.abort();
  }

  render() {
    return (
      <ul className="data__lists">
        {this.state.lists.map(list => {
          return (
            <li
              key={list.id}
              className="list"
              data-id={list.id}
            >
              {list.id} - {list.created_at} - {list.left_breast} - {list.right_breast} - {list.baby_bottle}
              <DeleteButton />
              <a className="jobs__edit" href={"/" + list.id + "/edit"}>EDIT</a>
            </li>
          );
        })}
      </ul>
    );
  }
}