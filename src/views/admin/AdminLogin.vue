<script setup>
import { adminuserRegisterService, adminuserLoginService } from '@/api/admin.js'
import { User, Lock } from '@element-plus/icons-vue'
import { ref, watch } from 'vue'
import { useUserStore } from '@/stores'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'

const isRegister = ref(false)
const form = ref()

const formModel = ref({
  Username: '',
  Password: '',
  repassword: ''
})

const rules = {
  Username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 5, max: 10, message: '用户名必须是 5-10位 的字符', trigger: 'blur' }
  ],
  Password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    {
      pattern: /^\S{6,15}$/,
      message: '密码必须是 6-615位 的非空字符',
      trigger: 'blur'
    }
  ],
  repassword: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    {
      pattern: /^\S{6,15}$/,
      message: '密码必须是 6-15位 的非空字符',
      trigger: 'blur'
    },
    {
      validator: (rule, value, callback) => {
        if (value !== formModel.value.Password) {
          callback(new Error('两次输入密码不一致'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ]
}

const register = async () => {
  await form.value.validate()
  await adminuserRegisterService(formModel.value)
  ElMessage.success('注册成功')
  isRegister.value = false
}

const userStore = useUserStore()
const router = useRouter()

const clearLocalStorage = () => {
  localStorage.clear()
  ElMessage.error('登录信息已失效，请重新登录')
}

const login = async () => {
  await form.value.validate()
  const res = await adminuserLoginService(formModel.value)
  userStore.setToken(res.data.token)
  ElMessage.success('登录成功！')
  router.push('/admin/layout')
  localStorage.setItem('res', JSON.stringify(res.data.data.Username))
  localStorage.setItem('avatar', JSON.stringify(res.data.data.avatar))
  localStorage.setItem('UserID', JSON.stringify(res.data.data.UserID))

  // 设置定时器，一天后清空本地存储
  const oneDay = 24 * 60 * 60 * 1000
  setTimeout(clearLocalStorage, oneDay)
}

watch(isRegister, () => {
  formModel.value = {
    Username: '',
    Password: '',
    repassword: ''
  }
})
</script>
<template>
  <el-row class="login-page">
    
   <div class="input_box">
    <el-col :span="auto" class="form">
      <!-- 注册相关表单 -->
      <el-form
        :model="formModel"
        :rules="rules"
        ref="form"
        size="large"
        autocomplete="off"
        v-if="isRegister"
      >
        <el-form-item>
         <el-col class="title">注册</el-col>
         <el-col class="title_text">register</el-col>
        </el-form-item>
        <el-form-item prop="Username">
          <el-input
            v-model="formModel.Username"
            :prefix-icon="User"
            placeholder="请输入用户名"
          ></el-input>
        </el-form-item>
        <el-form-item prop="Password">
          <el-input
            v-model="formModel.Password"
            :prefix-icon="Lock"
            type="password"
            placeholder="请输入密码"
          ></el-input>
        </el-form-item>
        <el-form-item prop="repassword">
          <el-input
            v-model="formModel.repassword"
            :prefix-icon="Lock"
            type="password"
            placeholder="请输入再次密码"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button
            @click="register"
            class="button"
            type="primary"
            auto-insert-space
          >
            注册
          </el-button>
        </el-form-item>

        <el-form-item class="flex">
          <el-link type="info" :underline="false" @click="isRegister = false">
            ← 返回
          </el-link>
        </el-form-item>

      
      </el-form>

      <!-- 登录相关表单 -->
      <el-form
        :model="formModel"
        :rules="rules"
        ref="form"
        size="large"
        autocomplete="off"
        v-else
      >
        <el-form-item>
          <el-col class="title">登录</el-col>
          <el-col class="title_text">login</el-col>
        </el-form-item>
        <el-form-item prop="Username">
          <el-input
            v-model="formModel.Username"
            :prefix-icon="User"
            placeholder="请输入用户名"
          ></el-input>
        </el-form-item>
        <el-form-item prop="Password">
          <el-input
            v-model="formModel.Password"
            name="Password"
            :prefix-icon="Lock"
            type="password"
            placeholder="请输入密码"
          ></el-input>
        </el-form-item>
        <el-form-item class="flex">
          <div class="flex">
            <el-checkbox>记住我</el-checkbox>
            <el-link type="info" :underline="false" href="/login">前往用户端</el-link>
            <el-link type="primary" :underline="false">忘记密码？</el-link>
          </div>
        </el-form-item>
        <el-form-item>
          <el-button
            @click="login"
            class="button"
            type="primary"
            auto-insert-space
            >登录</el-button
          >
        </el-form-item>
        <el-form-item class="flex">
          <el-link type="info" :underline="false" @click="isRegister = true">
            注册(商家) →
          </el-link>
        </el-form-item>

       

      </el-form>
    </el-col>
   </div>
  </el-row>
</template>

<style lang="scss" scoped>
.login-page {
  height: 100vh;
  background-color: #fff;
//   background: url(../../assets/shangjia_bg.png);
  .form {
    display: flex;
    flex-direction: column;
    justify-content: center;
    user-select: none;
    .title {
      margin: 0 auto;
    }
    .button {
      width: 100%;
    }
    .flex {
      width: 100%;
      display: flex;
      justify-content: space-between;
    }
    
  }
}
.input_box{
  width: 350px;
  margin: 0 auto;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: center;
}
.title{
 font-size: 30px;
    background:#131212;
    -webkit-background-clip: text;
    color: transparent;
    
}
.title_text{
  font-style: italic; /* 设置文字为斜体 */
  color: #131212; /* 设置文字颜色 */
  font-size: 56px;
}

</style>
