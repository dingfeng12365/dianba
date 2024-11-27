<template>
  <div>
    <div>
      <el-divider content-position="center">
        <h2>用户管理</h2>
      </el-divider>
      <el-divider content-position="left">
        <h3>用户信息查询</h3>
      </el-divider>
      <br />
      <!-- 输入框搜索 -->
      <div style="display: flex; align-items: center;">
        <el-input placeholder="请输入用户名" prefix-icon="el-icon-search" v-model="userName"
          style="width: 300px; margin-left: 70px; margin-right: 10px;"> <!-- Adjusted margin-left -->
        </el-input>
        <el-button @click="query()" type="primary" icon="el-icon-search">搜索</el-button>

        <!-- 筛选 -->

        <el-select v-model="q.roleId" placeholder="选择状态" popper-class="custom-popper" style="margin-left: 50px;">
          <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
        </el-select>


        <!-- 增加 -->
        <el-button @click="dialogVisible1 = true" type="primary" icon="el-icon-edit"
          style="margin-left: 400px;">新建用户</el-button>
      </div>
      <br />

      <el-divider content-position="left">
        <h3>用户信息</h3>
      </el-divider>
    </div>

    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="userId" label="用户编号" width="150" align="center">
      </el-table-column>
      <el-table-column prop="userName" label="用户名" width="150" align="center">
      </el-table-column>
      <el-table-column prop="phone" label="电话" width="150" align="center">
      </el-table-column>
      <el-table-column prop="password" label="密码" width="150" align="center">
      </el-table-column>
      <el-table-column prop="roleId" label="用户类别" width="150" align="center">
      </el-table-column>
      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div style="display: flex; justify-content: center; margin: 20px 0;">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
        :page-sizes="[10, 20, 30, 40]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
        :total="total">
      </el-pagination>
    </div>

    <!-- 插入弹窗 -->
    <el-dialog title="新建用户" :visible.sync="dialogVisible1" width="30%" :before-close="handleClose">
      <span>
        <el-form ref="form1" :model="form1" label-width="80px">

          <el-form-item label="用户名">
            <el-input v-model="form1.userName"></el-input>
          </el-form-item>
          <el-form-item label="电话">
            <el-input v-model="form1.phone"></el-input>
          </el-form-item>
          <el-form-item label="密码">
            <el-input v-model="form1.password"></el-input>
          </el-form-item>
          <el-form-item label="用户类别">
            <el-select v-model="form1.roleId" placeholder="请选择">
              <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible1 = false">取消</el-button>
        <el-button type="primary" @click="add()">确 定</el-button>
      </span>
    </el-dialog>

    <!-- 编辑弹窗 -->
    <el-dialog title="编辑信息" :visible.sync="dialogVisible2" width="30%" :before-close="handleClose">
      <span>
        <el-form ref="form" :model="form" label-width="80px">
          <el-form-item label="用户id">
            <el-input :disabled="true" v-model="form.userId"></el-input>
          </el-form-item>
          <el-form-item label="用户名">
            <el-input v-model="form.userName"></el-input>
          </el-form-item>
          <el-form-item label="电话">
            <!-- 手机号为11位数字 -->
            <el-input v-model="form.phone" @input="checkPhone"></el-input>
            <p v-if="phoneError" class="error-message"></p>
          </el-form-item>
          <el-form-item label="密码">
            <el-input v-model="form.password"></el-input>
          </el-form-item>
          <el-form-item label="用户类别">
            <el-select v-model="op2.roleId" placeholder="请选择">
              <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible2 = false">取消</el-button>
        <!-- phoneError为true时，禁止点击确定按钮 -->
        <el-button :disabled="phoneError" type="primary" @click="update()">确 定</el-button>
      </span>
    </el-dialog>


  </div>
</template>


<script>
import axios from 'axios'

export default {
  data() {
    return {
      tableData:{},
      dialogVisible1: false,
      dialogVisible2: false,
      pageNum: 1,
      pageSize: 10,
      total: 0,

      userId: '',
      userName: '',
      password: '',
      phone: '',
      roleId: '',
      phoneError: false,
      form: {
        userName: '',
        password: '',
        phone: '',
        roleId: ''
      },
      form1: {
        userName: '',
        password: '',
        phone: '',
        roleId: ''
      },
      op1: {
        roleId: '',
      },
      op2: {
        roleId: '',
      },
      q: {
        roleId: '',
      },

      options: [{
        value: '3',
        label: '管理员'
      },
      {
        value: '1',
        label: '普通用户'
      }
      ]
      ,
    }
  },
  watch: {
    'q.roleId': function (newValue) {
      this.queryDan(newValue);
    }
  },
  methods: {
    /* 获取数据 */
    getData() {
      axios.get(`${process.env.VUE_APP_API_URL}/users/getByPage`, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data.records;
        this.total = res.data.total;
        this.pageNum = res.data.current;
        this.pageSize = res.data.size;
      })
    },
    /* 查询 */
    query() {
      axios.get(`${process.env.VUE_APP_API_URL}/users/getByName`, {
        params: {
          userName: this.userName
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data;
      })
    },
    queryDan() {
      axios.get(`${process.env.VUE_APP_API_URL}/users/getByRoleId`, {
        params: {
          roleId: this.q.roleId
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data;
      })
    },
    /* 分页 */
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
    /* 编辑 */
    handleEdit(index, row) {
      console.log(index, row);
      this.dialogVisible2 = true;
      this.form = row;
    },
    /* 删除 */
    handleDelete(index, row) {
      console.log(index, row);
      axios.get(`${process.env.VUE_APP_API_URL}/users/delByUserId`, {
        params: {
          userId: row.userId
        }
      }).then(res => {
        console.log(res.data);
        //刷新数据
        this.getData();
      })
    },
    /* 关闭弹窗 */
    handleClose() {
      this.dialogVisible1 = false;
      this.dialogVisible2 = false;
    },
    /* 更新 */
    update() {
      axios.post(`${process.env.VUE_APP_API_URL}/users/update`, this.form)
        .then(res => {
          console.log(res);
        })
        .catch(error => {
          console.log(error);
        });
      this.dialogVisible2 = false;
    },
    /* 增加数据 */
    add() {
      axios.post(`${process.env.VUE_APP_API_URL}/users/addUsers`, this.form1)
        .then(res => {
          console.log(res);
          this.getData();
        })
        .catch(error => {
          console.log(error);
        });
      this.dialogVisible1 = false;
    },
    checkPhone() {
      // 验证手机号
      const reg = /^1[3456789]\d{9}$/;
      this.phoneError = !reg.test(this.form.phone);
      // console.log(this.phoneError);
    }

  },
  mounted(){
    this.getData()
  }
}

</script>
<style scoped>

.error-message {
  color: red; /* 设置为红色文字 */  
  margin-top: 5px; /* 与输入框之间留点空间 */  
}
</style>