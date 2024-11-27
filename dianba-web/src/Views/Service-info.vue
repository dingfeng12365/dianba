<template>
  <div>
    <div>
      <el-divider content-position="center">
        <h2>客服管理</h2>
      </el-divider>
      <el-divider content-position="left">
        <h3>客服信息查询</h3>
      </el-divider>
      <br />
      <!-- 输入框搜索 -->
      <div style="display: flex; align-items: center;">
        <el-input placeholder="请输入反馈id" prefix-icon="el-icon-search" v-model="feedBack"
          style="width: 300px; margin-left: 70px; margin-right: 10px;"> <!-- Adjusted margin-left -->
        </el-input>
        <el-button @click="query()" type="primary" icon="el-icon-search">搜索</el-button>

        <!-- 筛选 -->

        <el-select v-model="q.done" placeholder="选择完成状态" popper-class="custom-popper" style="margin-left: 50px;">
          <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
        </el-select>

      </div>
      <br />
      <el-divider content-position="left">
        <h3>客服信息</h3>
      </el-divider>
    </div>

    <!-- 表格 -->
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="feedId" label="反馈编号" width="100" align="center">
      </el-table-column>
      <el-table-column prop="feedBack" label="反馈内容" width="400" align="center">
      </el-table-column>
      <el-table-column prop="feedTime" label="反馈时间" width="200" align="center">
      </el-table-column>
      <el-table-column prop="done" label="完成状态" width="300" align="center">
      </el-table-column>

      <el-table-column label="更改完成状态">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑完成状态</el-button>
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

    <!-- 编辑弹窗 -->
    <el-dialog title="增加设备" :visible.sync="dialogVisible" width="30%" :before-close="handleClose">
      <span>
        <el-form ref="form" :model="form" label-width="80px">
          <el-form-item label="反馈id">
            <el-input :disabled="true" v-model="form.feedId"></el-input>
          </el-form-item>
          <el-form-item label="反馈内容">
            <el-input :disabled="true" v-model="form.feedBack"></el-input>
          </el-form-item>
          <el-form-item label="反馈时间">
            <el-input :disabled="true" v-model="form.feedTime"></el-input>
          </el-form-item>
          <el-form-item label="完成状态">
            <el-select v-model="form.done" placeholder="请选择">
              <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="update()">确 定</el-button>
      </span>
    </el-dialog>





  </div>

</template>


<script>
import axios from 'axios';
export default {
  data() {
    return {
      /* 改的 */
      dialogVisible: false,
      tableData:{},
      pageNum: 1,
      pageSize: 10,
      total: 0,

      feedId: '',
      feedBack: '',
      feedTime: '',
      done: '',
      form: {
        feedId: '',
        feedBack: '',
        feedTime: '',
        done: '',
      },

      q: {
        done: '',
      },
      options: [{
        value: '已处理',
        label: '已处理'
      },
      {
        value: '未处理',
        label: '未处理',
      }
      ],
    }
  },
  watch: {
    'q.done': function (newValue) {
      this.queryDan(newValue);
    }
  },
  methods: {
    /* 获取数据 */
    getData() {
      axios.get(`${process.env.VUE_APP_API_URL}/feedback/getByPage`, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data.records;
        this.total = res.data.total;
      })
    },
    /* 查询 */
    query() {
      axios.get(`${process.env.VUE_APP_API_URL}/feedback/getByFeedBack`, {
        params: {
          feedBack: this.feedBack
        }
      }).then(res => {
        console.log(this.feedBack);
        console.log(res.data);
        this.tableData = res.data;
      })
    },
    queryDan() {
      axios.get(`${process.env.VUE_APP_API_URL}/feedback/getByDone`, {
        params: {
          done: this.q.done
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data;
      })
    },
    /* 更新 */
    update() {
      axios.post(`${process.env.VUE_APP_API_URL}/feedback/update`, this.form)
        .then(res => {
          console.log(res);
        })
        .catch(error => {
          console.log(error);
        });
      this.dialogVisible = false;
    },
    /* 编辑 */
    handleEdit(index, row) {
        console.log(index, row);
        this.dialogVisible = true;
        this.form = row;
      },
      /* 关闭弹窗 */
      handleClose() {
      this.dialogVisible = false;
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
  },
  mounted(){
    this.getData()
  }
}

</script>