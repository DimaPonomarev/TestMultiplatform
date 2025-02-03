package com.example.fifth

sealed class ViewModelState {
    object Idle : ViewModelState()

    data class Loading(val message: String? = null) : ViewModelState()
    data class Error(val message: String?) : ViewModelState()
}