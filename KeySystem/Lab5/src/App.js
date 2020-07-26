import React from 'react';
import './App.css';
import 'antd/dist/antd.css';
import Users from './UsersTable'
import Modal from './Modal'

class App extends React.Component {
  render() {
    return (
      <div className="App">
        <Modal/>
        <Users/>
      </div>
    );
  }
}

export default App;
