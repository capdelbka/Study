import React from 'react';
import { Table } from 'antd';
import { connect } from 'react-redux';
import './App.css';
import { showModalAction } from './redux/actions'



class Users extends React.Component {
    state = {
        columns: [
            {
                title: 'ID',
                dataIndex: 'id',
                key: 'id'
            },
            {
                title: 'Имя пользователя',
                dataIndex: 'name',
                key: 'name'
            },
            {
                title: 'email',
                dataIndex: 'email',
                key: 'email'
            }
        ],
        data: [],

    }




    async componentDidMount() {
        const response = await fetch('https://jsonplaceholder.typicode.com/users')
        const users = await response.json();
        this.setState(() => {
            return {
                data: users
            }
        });
    }



    onChangeSpeed(e) {
        this.setState({ UserState: e })
    }

    

    render() {

        const {
            UBlock = [],


        } = this.props;
        const {
            columns,
            data,


        } = this.state;








        return this.Out(UBlock, columns, data)
    }

    onClick = (Ind) => {
        this.props.triggerModal(this.state.data[Ind], Ind, this.props.UBlock);
    }


    Out(UserState, columns, data) {

        return <div>
            <Table rowClassName={(record, Ind) => {

                
                return record.id === UserState[Ind + 1] ? "red" : ""


            }}
                onRow={(record, Ind) => {
                    return {
                        onClick: event => { this.onClick(Ind) }
                    };
                }}
                columns={columns} dataSource={data} />

        </div>
    }


}

const mapStateToProps = state => {
    return {
        UBlock: state.modal.UBlock
    }
}

const mapDispatchToProps = dispatch => {
    return {
        triggerModal: (data, id, UBlock) => {
            let action = showModalAction(data, id, UBlock)
            dispatch(action)
        }
    }
}
const ConnectedUsers = connect(
    mapStateToProps,
    mapDispatchToProps
)(Users)

export default ConnectedUsers
