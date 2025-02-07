package com.example.fifth

import dev.icerock.moko.mvvm.viewmodel.ViewModel
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.receiveAsFlow
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class LoginViewModel: RootViewModel<LoginViewModelActions>() {
    private val _login: MutableStateFlow<String> = MutableStateFlow("")
    val login = _login

    private val _password: MutableStateFlow<String> = MutableStateFlow("")
    val password = _password

    private val _isLoading: MutableStateFlow<Boolean> = MutableStateFlow(false)
    val isLoading = _isLoading

    private val _isButtonEnabled: MutableStateFlow<Boolean> = MutableStateFlow(false)
    val isButtonEnabled = _isButtonEnabled

    private val _isAlertShown = MutableStateFlow(false)
    val isAlertShown = _isAlertShown

    fun onLoginPressed() {
        _isLoading.value = true
        viewModelScope.launch {
            delay(1000)
            _isLoading.value = false
            isAlertShown.value = true
        }
    }

     fun setPassword(value: String) {
        _password.value = value
         onCheckFields()
    }

     fun setLogin(value: String) {
        _login.value = value
         onCheckFields()
    }

    private fun onCheckFields() {
        if (login.value.isNotBlank() && password.value.isNotBlank()) {
            _isButtonEnabled.value = true
        }
    }

    fun onShowNextScreen() {
        viewModelScope.launch {
            LoginViewModelActions.ShowNext.sendAction()
            _isAlertShown.value = false
        }
    }

    fun hideAlert() {
        _isAlertShown.value = false
    }


}

sealed class LoginViewModelActions: IViewModelActions {
    data object ShowNext: LoginViewModelActions()
}
interface IViewModelActions {}