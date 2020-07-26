import React from 'react';
import './App.css';
import  BlockUser  from './BlockUser.js'
import { connect } from 'react-redux'
import { showModalData } from './redux/actions'
import { Modal as AntdModal } from 'antd';


class Modal extends React.Component {    
    renderContent(content = null) {
        if (!content) return null;
        return (
            <div>
                <h1>Адрес:</h1>
                <p> город: {content.address.city} </p>
                <p> улица: {content.address.street} </p>
                <p> квартира: {content.address.suite} </p>
            </div>
        )
    }

    render() {
        const {
            visible = false,
            content = null
        } = this.props
        
        return (
            <AntdModal
                title="Дополнительная информация о пользователе"
                visible={visible}
                onOk={this.props.triggerModal}
                onCancel={this.props.triggerModal}
            >
                {this.renderContent(content)}
                <BlockUser/>
            </AntdModal>)
    }
}

const mapStateToProps = state => {
    return {
        visible: state.modal.visible,
        content: state.modal.UserData,
        UBlock: state.modal.UBlock,
    }
}

const mapDispatchToProps = dispatch => {
    return {
        triggerModal: () => {
            let action = showModalData()
            dispatch(action)
        }
    }
}

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(Modal)