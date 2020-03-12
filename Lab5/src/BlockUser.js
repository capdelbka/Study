/* eslint-disable react/react-in-jsx-scope */
import React from 'react'
import { Popconfirm, Button } from 'antd';
import { connect } from 'react-redux'
import { showModalAction } from './redux/actions'


class BlockUser extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            UBlock: []
        }
        this.onClick = this.onClick.bind(this);
      }



    onClick(data, id){
        let user = this.state.UBlock;
        user[id+1]=id+1;
        this.setState(()=>({
            UBlock:user,
        }))
        this.props.triggerModal(data, id, this.state.UBlock);
        
    }


    
    render () {
        const {   
            id = 0, 
            data = []
        } = this.props
        return (
            <Popconfirm
                title="Вы уверены что хотите заблокировать пользователя?"
                onConfirm={() => {this.onClick(data, id)}}
                okText="Да"
                cancelText="Нет"
            >
                <Button type='danger' > Заблокировать пользователя </Button>
            </Popconfirm>
        )
    }
    
};

const mapStateToProps = state => {
    return {
        id: state.modal.id,
        data: state.modal.UserData
    }
}

const mapDispatchToProps = dispatch => {
    return {
        triggerModal: (data, id, UserBlockIDARR) => {
            let action = showModalAction(data, id, UserBlockIDARR)
            dispatch(action)
        }
    }
}
const ConnectedUsers = connect(
    mapStateToProps,
    mapDispatchToProps
)(BlockUser)    

export default ConnectedUsers
