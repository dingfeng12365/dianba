<template>

    <div>

      <el-menu :default-active="activeIndex2" class="el-menu-demo" mode="horizontal" @select="handleSelect"
          background-color="#409eff" text-color="#fff" active-text-color="#ffd04b">
          <el-row gutter="5">
  
            <el-col :span='2' offset='0'>
            
              <img src="../assets/电霸logo.png" alt="logo" width="100%" height="100%">
              
            </el-col>
          
            <el-col :span='7'>
              <br>
              <img src="../assets/logo1.png" alt="logo1" width="100%" height=120%>
            </el-col>
            <el-col :span='2'>
              <br>
              <el-menu-item index="1">
                <router-link to="/zhuye">首页</router-link>
                </el-menu-item>
            </el-col>
            <el-col :span='2'>
              <br>
              <el-submenu index="2">
                <template slot="title">产品中心</template>
                <el-menu-item index="1-1"><router-link to="/tumb">二轮车充电桩</router-link></el-menu-item>
                <el-menu-item index="1-2"><router-link to="/auto">汽车充电桩</router-link></el-menu-item>
              </el-submenu>
            </el-col>

            <el-col :span='2'>
              <br>
              <el-submenu index="3">
                <template slot="title">关于我们</template>
            <!-- 公司简介路由跳转 -->
                <el-menu-item index="1-1"><router-link to="/intro">公司简介</router-link></el-menu-item>
                <el-menu-item index="1-2"><router-link to="/glory">公司荣誉</router-link></el-menu-item>
              </el-submenu>
            </el-col>
            <el-col :span='2'>
              <br>
              <el-menu-item index="4">
                <router-link to="/manage">管理中心</router-link>
                </el-menu-item>
            </el-col>
            <el-col :span='2'>
              <br>
              <el-menu-item index="5">
                <el-link :underline="false" @click="dialogVisible3 = true">登录/注册</el-link>
              </el-menu-item>
            </el-col>
            <el-col :span='4'>
              <br>
              <el-menu-item>
                <el-input placeholder="请输入内容" v-model="input1" class="input-with-select" size="medium">
                  <el-button size="mini" slot="append" icon="el-icon-search"></el-button>
                </el-input>
                <router-link to="/info">
                  <el-button type="warning" size="mini" icon="el-icon-user" round ></el-button>
                </router-link>
              </el-menu-item>
            </el-col>
          </el-row>
        </el-menu>

        <el-container>
          <el-header>
            
          </el-header>
          <el-main>
            <h1 class="custom-title">公司荣誉</h1>
            <p class="custom-paragraph">
              电霸共享充电公司凭借卓越的服务和创新的技术，获得了业界的广泛认可与赞誉。
              <br>
              <br>
              公司荣获“年度最佳共享充电服务品牌”奖、国家级“创新技术应用奖”和“用户满意度最高企业”奖项。
              <br>
              <br>
              这些荣誉不仅体现了我们在充电解决方案领域的领先地位，也彰显了我们致力于为用户提供高质量、可靠服务的坚定承诺。电霸共享充电公司将继续秉持创新驱动和用户至上的原则，为行业树立更高的标杆，推动共享充电服务向更广阔的未来迈进。
            </p>
            <br>
            <el-carousel :interval="4000" type="card" height="325px">
              <el-carousel-item v-for="(item, index) in imgList" :key="index">
                <img :src="item.imgUrl" alt="图片" width="100%" height="100%">
                <h3 class="medium">{{ item }}</h3>
              </el-carousel-item>
            </el-carousel>
          </el-main>
        </el-container>


        <!-- 注册弹窗 -->
        <el-dialog title="注册" :visible.sync="dialogVisible2" width="30%" :before-close="handleClose">
            <span>
              <el-form ref="form" :model="zhuCeForm" label-width="80px">
                <el-form-item label="用户名">
                  <el-input v-model="zhuCeForm.userName"></el-input>
                </el-form-item>
                <el-form-item label="手机号">
                  <el-input v-model="zhuCeForm.phone"></el-input>
                </el-form-item>
                <el-form-item label="密码">
                  <el-input v-model="zhuCeForm.password"></el-input>
                </el-form-item>
                <el-form-item label="确认密码">
                  <el-input v-model="password2"></el-input>
                </el-form-item>
              </el-form>
            </span>
            <span slot="footer" class="dialog-footer">
              <el-button @click="dialogVisible2 = false">取 消</el-button>
              <el-button type="primary" @click="addUsers()">确 定</el-button>
            </span>
          </el-dialog>
          <!-- 登录弹窗 -->
          <el-dialog title="登录" :visible.sync="dialogVisible3" width="30%" :before-close="handleClose">
            <span>
              <el-form ref="form" :model="loginForm" label-width="80px">
    
                <el-form-item label="用户名">
                  <el-input v-model="loginForm.userName"></el-input>
                </el-form-item>
                <el-form-item label="密码">
                  <el-input v-model="loginForm.password"></el-input>
                </el-form-item>
              </el-form>
            </span>
            <span slot="footer" class="dialog-footer">
              <el-button @click="handleClick()" type="info" plain>立即注册！</el-button>
              <el-button @click="dialogVisible3 = false">取消</el-button>
              <el-button type="primary" @click="login()">确 定</el-button>
            </span>
          </el-dialog>
          <br>
          <br>

         
    </div>


</template>

<script>
  
  import axios from 'axios'
  
  //引入组件01Button.vue
  //import MyButton from './components/Button-01.vue';
  //import MyLayout from './components/Layout-02.vue';
  // import MyTable from './components/Table-03.vue';
  
  //import MyTable from './components/MyTable.vue';
  //写入js代码
  export default {
    name: 'App',
    data() {
      return {
        form: {
          user_id: '',
          password: '',
        },
        //登录表单
        loginForm: {
          userName: '',
          password: '',
        },
  
        //注册表单
        zhuCeForm: {
          userName: '',
          password: '',
          phone: '',
          roleId: '1',
          //默认注册用户为普通用户
  
        },
        password2: '',//登录注册弹窗1
        dialogVisible2: false,//注册弹窗
        dialogVisible3: false,
        // 搜索框
        input: '',
        searchVisible: false,//搜索跳转
  
        imgList: [
          { imgUrl: require('../assets/荣誉1.png') },
          { imgUrl: require('../assets/荣誉2.png') },
          { imgUrl: require('../assets/荣誉3.png') },
          { imgUrl: require('../assets/荣誉4.png') },
  
        ],
  
      
      }
    },
    methods: {
      // 点击事件
      handleEdit(index, row) {
        console.log(index, row);
  
        this.dialogVisible = true;
  
        this.form = row;
  
      },
      handleClose() {
        this.dialogVisible3 = false;
        this.dialogVisible2 = false;
      },
      handleClick() {
        this.dialogVisible3 = false; // 关闭第一个对话框  
        this.dialogVisible2 = true;  // 打开第二个对话框  
      },
      addUsers() {
        axios.post(`${process.env.VUE_APP_API_URL}/users/addUsers`, this.zhuCeForm)
          .then(response => {
            console.log(response);
          })
          .catch(error => {
            console.log(error);
          })
        this.dialogVisible2 = false;
      },
      login() {
        console.log(this.loginForm);
        axios.post(`${process.env.VUE_APP_API_URL}/users/login`, this.loginForm)
        .then(res => {
          if (res.data) {
            alert('登录成功!');
          } else {
            alert('登录失败，请检查用户名和密码！');
          }
        })
        this.dialogVisible3 = false;
      },
  
    }
  
  }
</script>
  <style scoped>
  .el-container {
    background-image: url("../assets/公司简介背景.jpg");
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
    background-color: rgba(255, 255, 255, 0.25); /* 添加半透明的白色背景 */
    background-blend-mode: overlay; /* 设置混合模式 */
  }
  轮播图-->el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 400px;
    margin: 0;
  }
  
  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }
  
  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
  .content::after {
    content: "";
    display: block;
    height: 1600px;
    visibility: hidden;
  }
  
  
  .el-link {
    color: #f8f9fa;
  }
  

  .el-container {
    height: 800px;
  }
  
  .el-main {
    display: flex;
    flex-direction: column;
}

.custom-title {
    text-align: center; /* 居中对齐标题 */
    font-size: 40px; /* 设置标题字体大小 */
    color: #080808; /* 设置标题颜色 */
}

.custom-paragraph {
    font-size: 20px; /* 设置段落字体大小 */
    color: #0f0e0e; /* 设置段落颜色 */
}
  .el-aside {
    background-color: #f9fafb;
    color: #333;
    text-align: center;
    line-height: 700px;
    
  }
  
  .router-link-active {
    color:#333;
    text-decoration: none;
  }
  a {
    color: rgb(253, 251, 251);
    text-decoration: none;
  }
  </style>
  