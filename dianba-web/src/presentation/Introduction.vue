<template>

    <div>
      
      <!-- 菜单导航栏 -->
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

      <!-- 展示模块 -->
        <el-container>
          <el-header>
          </el-header>
          <el-main>
            <h1 class="custom-title">公司简介</h1>
            <p class="custom-paragraph">
              电霸共享充电公司致力于提供便捷、高效的充电解决方案，以满足现代人对用电设备充电的需求。作为一家领先的共享充电服务提供商，电霸采用先进的技术和智能设备，在全国范围内布局了大量的共享充电点位。我们的充电设施经过严格的安全检测，确保为用户提供稳定可靠的电力支持。
              <br>
              <br>
              电霸共享充电公司以用户为中心，通过灵活的租赁方式和便捷的操作流程，帮助用户轻松解决充电难题。无论是在小区，商场还是公共交通枢纽，用户都能迅速找到各种设备的共享充电设施。我们致力于不断提升服务质量和用户体验，以创新驱动行业发展，引领共享充电市场的未来。
            </p>
            <p class="custom-paragraph">
              新能源综合产业企业
              多年技术沉淀，成就行业口碑
              电霸充电共享公司是专注于新能源汽车、二轮电动车以及移动设备充电设备的领导品牌，集研发、生产、销售、建设、运营为一体的充电设备整体解决方案提供商。京能新能源凭借的充电桩研发技术和成熟的充电站运营管理经验，为客户提供专业全面、的充电设备及充电站建设运营一体化解决方案
              依托深厚的行业经验、雄厚的资金实力、强大的研发能力和产品运维服务体系，在充电桩和充电站一体化建设运营领域持续为客户创造价值，为中国新能源产业发展提供了有力的支撑
              </p>
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
          

          
    </div>
</template>

<script>
  
  import axios from 'axios'
  
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

  .router-link-active {
    color:#333;
    text-decoration: none;
  }
  a {
    color: rgb(253, 251, 251);
    text-decoration: none;
  }
  </style>
  