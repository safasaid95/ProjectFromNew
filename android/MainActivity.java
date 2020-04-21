package com.example.malli.passwordencrypting;

import android.content.Context;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;

import java.util.HashMap;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        AES_EncryptDecrypt aes = new AES_EncryptDecrypt();

        //Encryption test
        String userName = "UserName";
        String passWord = "PassWord";
        byte[] bytes = userName.getBytes();
        HashMap<String, byte[]> map = aes.encryptBytes(bytes, passWord);

        SharedPreferences.Editor editor = getSharedPreferences("prefs", Context.MODE_PRIVATE).edit();
        String keyBase64String = Base64.encodeToString("encrypt".getBytes(), Base64.NO_WRAP);
        String valueBase64String = Base64.encodeToString(map.get("encrypted"), Base64.NO_WRAP);
        editor.putString(keyBase64String, valueBase64String);
        editor.commit();

//Decryption test
        byte[] decrypted = aes.decryptData(map, passWord);
        if (decrypted != null)
        {
            String decryptedString = new String(decrypted);
            Log.e("MYAPP", "Decrypted String is : " + decryptedString);
        }

        SharedPreferences preferences = getSharedPreferences("prefs", Context.MODE_PRIVATE);
        String base64EncryptedString = preferences.getString(keyBase64String, "default");
        byte[] encryptedBytes = Base64.decode(base64EncryptedString, Base64.NO_WRAP);

        Log.e("MYAPP", "Decrypted String is value : " + new String(encryptedBytes,Base64.NO_WRAP));

    }
}
