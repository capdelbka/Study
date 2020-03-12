import {
    combineReducers,
} from 'redux';
import {CHANGE_MODAL_VISIBLE} from './action-types'
import {CHANGE_MODAL_Data} from './action-types'

const initialState = {
    visible: false,
    UserData: null,
    UBlock: [],
    id: 0
}

export const modal = (state = initialState, action) => {
    if (action.type === CHANGE_MODAL_VISIBLE) {
        return {
            visible: !state.visible,
            UBlock: action.UBlock,
            UserData: action.Udata,
            id: action.id,
        }
    }
    if (action.type === CHANGE_MODAL_Data) {
        return {
            visible: !state.visible,
            UBlock: state.UBlock,
        }
    }
    return state;
};

export const reducers = combineReducers({
    modal,
});
