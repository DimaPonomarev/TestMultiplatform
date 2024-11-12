package com.example.fifth

import dev.icerock.moko.mvvm.flow.CFlow
import dev.icerock.moko.mvvm.flow.CMutableStateFlow
import dev.icerock.moko.mvvm.flow.CStateFlow
import dev.icerock.moko.mvvm.flow.cFlow
import dev.icerock.moko.mvvm.flow.cMutableStateFlow
import dev.icerock.moko.mvvm.flow.cStateFlow
import dev.icerock.moko.mvvm.viewmodel.ViewModel
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.receiveAsFlow
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class LoginViewModel : ViewModel() {
    val login: CMutableStateFlow<String> = MutableStateFlow("").cMutableStateFlow()
    val password: CMutableStateFlow<String> = MutableStateFlow("").cMutableStateFlow()

    private val _isLoading: MutableStateFlow<Boolean> = MutableStateFlow(false)
    val isLoading: CStateFlow<Boolean> = _isLoading.cStateFlow()
    val isButtonEnabled: CStateFlow<Boolean> =
        combine(isLoading, login, password) { isLoading, login, password ->
            isLoading.not() && login.isNotBlank() && password.isNotBlank()
        }.stateIn(viewModelScope, SharingStarted.Eagerly, false).cStateFlow()

    private val _isAlertShown = MutableStateFlow(false)
    val isAlertShown = _isAlertShown.cMutableStateFlow()

    private val _actions = MutableSharedFlow<Action>(replay = 1) // replay хранит последнее значение
    val actions: CFlow<Action> get() = _actions.asSharedFlow().cFlow()

    fun onLoginPressed() {
        _isLoading.value = true
        viewModelScope.launch {
            delay(1000)
            _isLoading.value = false
            isAlertShown.value = true
        }
    }

    suspend fun onShowNextScreen() {
        _actions.emit(Action.ShowNext)
        _isAlertShown.value = false
    }

    fun hideAlert() {
        _isAlertShown.value = false
    }

    sealed interface Action {
        data object ShowNext: Action
    }
}