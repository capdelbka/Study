import { CHANGE_MODAL_VISIBLE } from './action-types'
import { CHANGE_MODAL_Data } from './action-types'

export const showModalAction = (data, id, UBlock) => {
    return {
        type: CHANGE_MODAL_VISIBLE,
        UBlock: UBlock,
        Udata: data,
        id: id,
    }
}

export const showModalData = () => {
    return {
        type: CHANGE_MODAL_Data,
    }
}