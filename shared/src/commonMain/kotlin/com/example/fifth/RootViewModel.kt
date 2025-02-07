package com.example.fifth

import dev.icerock.moko.mvvm.flow.CMutableStateFlow
import dev.icerock.moko.mvvm.flow.cMutableStateFlow
import dev.icerock.moko.mvvm.viewmodel.ViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.Job
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.receiveAsFlow
import kotlinx.coroutines.launch


open class RootViewModel<VMA : IViewModelActions> : ViewModel() {

    protected var _currentNetJob: Job? = null

    private val _actions = Channel<VMA>()

    val actions: Flow<VMA> = _actions.receiveAsFlow()

    protected fun rootViewModelScopeIO(block:suspend() -> Unit){
        viewModelScope.launch(Dispatchers.IO) {
            block()
        }
    }


    open fun setAction(action: VMA) {
        action.sendAction()
    }

    fun VMA.sendAction() {
        _currentNetJob?.cancel()
        _currentNetJob = viewModelScope.launch {
            _actions.send(this@sendAction)
        }
    }
}