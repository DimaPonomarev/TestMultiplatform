package com.example.fifth.android

import android.content.Context
import android.widget.Toast
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.fifth.LoginViewModel
import dev.icerock.moko.mvvm.flow.compose.observeAsActions

@Composable
fun LoginScreen(
    viewModel: LoginViewModel
) {
    val context: Context = LocalContext.current

    val login: String by viewModel.login.collectAsState()
    val password: String by viewModel.password.collectAsState()
    val isLoading: Boolean by viewModel.isLoading.collectAsState()
    val isLoginButtonEnabled: Boolean by viewModel.isButtonEnabled.collectAsState()

    viewModel.actions.observeAsActions { action ->
        when (action) {
            LoginViewModel.Action.LoginSuccess ->
                Toast.makeText(context, "login success!", Toast.LENGTH_SHORT).show()
        }
    }

    Column(
        modifier = Modifier.padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        androidx.compose.material.TextField(
            modifier = Modifier.fillMaxWidth(),
            value = login,
            enabled = !isLoading,
            label = { androidx.compose.material.Text(text = "Login") },
            onValueChange = { viewModel.login.value = it }
        )
        Spacer(modifier = Modifier.height(8.dp))
        androidx.compose.material.TextField(
            modifier = Modifier.fillMaxWidth(),
            value = password,
            enabled = !isLoading,
            label = { androidx.compose.material.Text(text = "Password") },
            visualTransformation = PasswordVisualTransformation(),
            onValueChange = { viewModel.password.value = it }
        )
        Spacer(modifier = Modifier.height(8.dp))
        androidx.compose.material.Button(
            modifier = Modifier
                .fillMaxWidth()
                .height(48.dp),
            enabled = isLoginButtonEnabled,
            onClick = viewModel::onLoginPressed
        ) {
            if (isLoading) androidx.compose.material.CircularProgressIndicator(
                modifier = Modifier.size(
                    24.dp
                )
            )
            else androidx.compose.material.Text(text = "Login")
        }
    }
}

@Preview
@Composable
fun DefaultPreview() {
    MyApplicationTheme {
        LoginScreen(viewModel = viewModel())
    }
}