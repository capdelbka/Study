import React from 'react';

import './App.css';

class App extends React.Component {
 constructor(props) {
    super(props);
    this.state = {value: ''};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleSubmit(event) {
    var text =this.state.value;    
    this.state.value='';
    document.getElementById("txt").value='';
    if(text !=='') {
     this.createItem(text)
    }
  }
 createItem(count) {
  var node = document.createElement("DIV")
  node.innerText = count;
  document.getElementById("zametka").appendChild(node);
}
deleteItem() {
  if(document.getElementById("zametka").lastChild)
  document.getElementById("zametka").lastChild.remove();
}
  render() {
    return (
      <div>
        <input type="button" value="Создать заметку" onClick={this.handleSubmit}  ></input>
        <input id="txt" type="text" value={this.state.value} onChange={this.handleChange} />
        <input type="button" value="Удалить последнюю заметку" onClick={this.deleteItem}  ></input>
        <div id="zametka"></div>
     
      </div>
      
    )
  }
}
export default App;
