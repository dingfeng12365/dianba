<template>
  <div class="personalCenter">
    <el-container>
      <el-header>
        <div style="display: flex; justify-content: space-between; align-items: center;">

          <el-dropdown>
            <span class="el-dropdown-link">
              个人中心<i class="el-icon-arrow-down el-icon--right"></i>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>
                <router-link to="/apply">设备申请</router-link>
              </el-dropdown-item>
              <el-dropdown-item>
                <router-link to="/earning">个人收益</router-link>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
          <div style="display: flex; align-items: center;">
            <router-link to="/">
              <el-button type="primary" size="medium" round @click="returnzhuye">返回主页</el-button>
            </router-link>
            <el-button type="primary" size="medium" round @click="handleLogout"
              style="margin-left: 10px;">退出</el-button>
          </div>
        </div>
      </el-header>
      <el-container>
        <el-aside width="300px">
          <el-col :span="12">
            <div class="sub-title"></div>
            <div class="demo-basic--circle" style="display: flex; 
              flex-direction: column; justify-content: center; align-items: center;">
              <div class="img" style="text-align: center;">
                <el-avatar :size="100" :src="circleUrl"></el-avatar>
              </div>
              <div class="block" style="text-align: center;">
                <span>AD</span>
              </div>
            </div>
          </el-col>
          <!-- 给出用户基本信息 -->
          <el-input :disabled="true" v-model="showForm.userId" type="text" placeholder="用户ID"></el-input>
          <el-input v-model="showForm.userName" type="text" placeholder="用户昵称"></el-input>
          <el-input v-model="showForm.password" placeholder="用户密码" show-password></el-input>
          <el-input :disabled="true" v-model="showForm.roleId" type="text" placeholder="类别" maxlength="4"></el-input>
          <el-input v-model="showForm.phone" type="text" placeholder="电话" maxlength="20"></el-input>
          <br />
          <!-- 按钮 -->
          <el-button @click="dialogVisible = true" type="warning" plain>反馈客服</el-button>
          <el-button type="primary" plain>保存修改</el-button>

        </el-aside>
        <el-container>
          <el-main>
            <!-- <el-card class="box-card">
                <div slot="header" class="clearfix">
                </div>
              </el-card> -->
            <el-card class="box-card" style="width: 98%;">

              <div>
                <span style="float: left" shadow="hover"><b>充电桩信息</b></span>
                <!-- 搜索 -->
                <div class="search-box">
                  <el-input v-model="position" placeholder="请输入地址搜索"
                    style="width: 200px; margin-right: 10px;"></el-input>
                  <el-button type="primary" @click="query()">搜索</el-button>
                </div>
                <br />
                <!-- 筛选 -->
                <br />

              </div>

              <!--表格 -->
              <el-table :data="tableData" style="width: 100%" :row-class-name="tableRowClassName">

                <el-table-column prop="chargeId" label="充电桩id" width="100">
                </el-table-column>
                <el-table-column prop="launch" label="启动" width="100">
                  <template slot-scope="scope">
                    <el-switch v-model="scope.row.value2" active-color="#13ce66" inactive-color="#ff4949">
                    </el-switch>
                  </template>
                </el-table-column>
                <el-table-column prop="position" label="电桩地址">
                </el-table-column>
                <el-table-column prop="zhuangTai" label="电桩状态" width="100">
                </el-table-column>
                <el-table-column prop="owningId" label="所属id">
                </el-table-column>

              </el-table>
              <br />

              <!-- 分页 -->

              <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                :current-page="pageNum" :page-sizes="[5, 10, 15, 20]" :page-size="pageSize"
                layout="total, sizes, prev, pager, next, jumper" :total="total">
              </el-pagination>

            </el-card>
            <el-card class="box-card" style="width: 98%;">
              <div>
                <span style="float: left" shadow="hover"><b>个人留言</b></span>
                <br />
                <br />
                <span>螃蟹在剥我的壳</span>
                <el-divider></el-divider>
                <span>漫天的我落在枫叶的雪花上</span>
              </div>
            </el-card>


          </el-main>
        </el-container>
      </el-container>
    </el-container>

    <!-- 弹窗 -->
    <el-dialog title="提示" :visible.sync="dialogVisible" width="30%" :before-close="handleClose">
      <span>
        <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-form-item label="反馈内容">
            <el-input v-model="ruleForm.feedBack" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="反馈时间">
            <el-date-picker v-model="ruleForm.feedTime" align="right" type="date" placeholder="选择日期"
              :picker-options="pickerOptions">
            </el-date-picker>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submit('ruleForm')">提交</el-button>
            <el-button @click="dialogVisible = false">取消</el-button>
          </el-form-item>
        </el-form>
      </span>

    </el-dialog>

  </div>


</template>
<script>
import axios from 'axios'
export default {
  name: 'PersonalCenter',
  methods: {
    getData() {
      axios.get(`${process.env.VUE_APP_API_URL}/charge/getByPage1`, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          owningId: localStorage.getItem('userId'),
        }
      }).then(res => {
        console.log("======================================");

        console.log(res.data);
        this.tableData = res.data.records;
        this.total = res.data.total;
        this.pageNum = res.data.current;
        this.pageSize = res.data.size;
      })
    },
    tableRowClassName({ rowIndex }) {
      if (rowIndex === 1) {
        return 'warning-row';
      } else if (rowIndex === 3) {
        return 'success-row';
      }
      return '';
    },
    update() {
      axios.post(`${process.env.VUE_APP_API_URL}/charge/update`, this.form)
        .then(res => {
          console.log(res);
        })
        .catch(error => {
          console.log(error);
        });
      this.dialogVisible = false;
    },
    //提交反馈
    submit() {
      axios.post(`${process.env.VUE_APP_API_URL}/feedback/add`, this.ruleForm)
        .then(res => {
          console.log(res);
        })
        .catch(error => {
          console.log(error);
        });
      this.dialogVisible = false;
    },
    query() {
      axios.get(`${process.env.VUE_APP_API_URL}/charge/getByPosition2`, {
        params: {
          position: this.position,
          userId: localStorage.getItem('userId'),
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data;
      })
    },
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.pageSize = val;
      this.getData();
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.pageNum = val;
      this.getData();
    },
    handleLogout() {
      //退出登录，清除本地存储
      localStorage.clear();
      //退出登录，跳转到首页界面并且给出已退出登录的提示
      this.$router.push('/')
        .then(() => {
          this.$message({
            message: '退出登录成功',
            type: 'success'
          })
        })
    },
    //如果roleId为3，则显示管理员，否则显示普通用户
    chargeRoleId() {
      if (this.showForm.roleId == 3) {
        this.showForm.roleId = '管理员'
      } else {
        this.showForm.roleId = '普通用户'
      }
    },


  },
  data() {
    return {
      //分页属性当前页
      pageNum: 1,
      //分页属性每页显示条数
      pageSize: 5,
      //分页属性总条数
      total: 100,
      tableData: {},
      circleUrl:
        'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',

      //自动查询

      chargeId: '',
      launch: true,
      position: '',
      zhuangTai: '',
      owningId: '',
      ruleForm: {
        feedId: '',
        feedBack: '',
        feedTime: '',
        done: '未完成',
      },
      //showForm用于展示用户信息
      showForm: {
        userId: localStorage.getItem('userId'),
        userName: localStorage.getItem('userName'),
        password: localStorage.getItem('password'),
        phone: localStorage.getItem('phone'),
        roleId: localStorage.getItem('roleId'),
      },
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        },
        shortcuts: [{
          text: '今天',
          onClick(picker) {
            picker.$emit('pick', new Date());
          }
        }, {
          text: '昨天',
          onClick(picker) {
            const date = new Date();
            date.setTime(date.getTime() - 3600 * 1000 * 24);
            picker.$emit('pick', date);
          }
        }, {
          text: '一周前',
          onClick(picker) {
            const date = new Date();
            date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
            picker.$emit('pick', date);
          }
        }]
      },

      value2: false,
      dialogVisible: false
    }
  },
  mounted() {
    this.getData()
    this.chargeRoleId()
    // this.getUserInfo()
  }
}
</script>
<style>
.el-header {
  line-height: 60px;
  text-align: center;
  background-color: #b3c0d1;
}

.el-aside {
  line-height: 72px;
  text-align: center;
  background-color: #d3dce6;
}

.el-main {
  line-height: 30px;
  text-align: center;
  background-color: #e9eef3;
}

.demo-basic--circle {
  text-align: 'center';
  margin-top: 30px;
  margin-left: 150px;
}

.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}



.clearfix:before,
.clearfix:after {
  display: table;
  content: '';
}

.clearfix:after {
  clear: both;
}



.demo-basic--circle {
  display: flex;
  flex-direction: column;
  justify-content: center;
  /* 垂直居中 */
  align-items: center;
  /* 水平居中 */
  height: 100%;
  /* 设置高度为100%，以确保容器占据整个el-aside的高度 */
}

.block span {
  display: block;
  margin-top: 10px;
  /* 可以根据需要调整间距 */
}

.main-container {
  width: 100%;
}

.box-card {
  width: 100%;
}

.el-table .warning-row {
  background: oldlace;
}

.el-table .success-row {
  background: #f0f9eb;
}

.el-dropdown-link {
  cursor: pointer;
  color: #5899fc;
}

.el-icon-arrow-down {
  font-size: 12px;
}

.search-box {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 20px;
}

.router-link-active {
  color: #ffd04b;
  text-decoration: none;
}

a {
  color: rgb(11, 10, 10);
  text-decoration: none;
}
</style>


