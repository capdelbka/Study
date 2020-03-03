import React from 'react';
import './App.css';
import {Table} from 'antd';
import 'antd/dist/antd.css';



class App extends React.Component {
  constructor() {
    super()
    this.state = {
        data: [],
        colum:[{
          title: 'ID',
          dataIndex: 'id',
          key: 'id',
        },
        {
          title: 'Ndme',
          dataIndex: 'name',
          key: 'name',
        },
        {
          title: 'Email',
          dataIndex: 'email',
          key: 'email',
        },]
    }
  
  }
   async componentDidMount() {
     const response = await fetch("https://jsonplaceholder.typicode.com/users");
    const users = await response.json();
      this.setState({ data:users}        )
      
    
     
  }

  render() {
    
    return (

      <div>
        <Table  dataSource={this.state.data} columns={this.state.colum} />      
      </div>
    )
  }
}

export default App;
