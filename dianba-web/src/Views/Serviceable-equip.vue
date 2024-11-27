<template>

    <div>
        <el-divider content-position="left">
            <h3>可用设备</h3>
        </el-divider>
        <br>

        <!-- 搜索框 -->
        <el-input placeholder="请输入设备名称" prefix-icon="el-icon-search" v-model="position"
            style="width: 300px; margin-left: 70px; margin-right: 10px;"> <!-- Adjusted margin-left -->
        </el-input>
        <el-button @click="query()" type="primary" icon="el-icon-search">搜索</el-button>

        <el-button @click="dialogVisible = true" type="primary" style="margin-left: 500px;">提交申请</el-button>

        <br>
        <el-divider></el-divider>

        <!-- 可用设备表格 -->
        <el-table :data="tableData" style="width: 100%" @selection-change="handleSelectionChange">
            <el-table-column prop="chargeId" label="设备编号" width="250" align="center">
            </el-table-column>
            <el-table-column prop="chargeName" label="设备名称" width="250" align="center">
            </el-table-column>
            <el-table-column prop="position" label="设备地址" width="250" align="center">
            </el-table-column>
            <el-table-column prop="cost" label="设备费用" width="250" align="center">
            </el-table-column>
            <el-table-column class-name="selection" label="勾选" type="selection" width="35"></el-table-column>
        </el-table>
        <br>
        <el-divider>
        </el-divider>


        <!-- 分页 -->
        <div style="display: flex; justify-content: center; margin: 20px 0;">
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
                :page-sizes="[10, 20, 30, 40]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                :total="total">
            </el-pagination>
        </div>

        <!-- 弹窗 -->
        <el-dialog title="申请表" :visible.sync="dialogVisible" width="30%" :before-close="handleClose">
            <el-table :data="selectedRows" style="width: 100%; margin-top: 20px">
                <el-table-column prop="chargeId" label="设备编号" width="100" align="center"></el-table-column>
                <el-table-column prop="chargeName" label="设备名称" width="100" align="center"></el-table-column>
                <el-table-column prop="cost" label="设备费用" width="100" align="center"></el-table-column>
                <el-table-column prop="applicant" label="申请人id" width="100" align="center"></el-table-column>
            </el-table>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="updateSelectedEquipments">确 定</el-button>
            </span>
        </el-dialog>
    </div>

</template>

<script>
import axios from 'axios';
export default {
    mounted() {
        this.getData()
    },
    data() {
        return {
            tableData: {},
            dialogVisible: false,
            chargeId: '',
            chargeName: '',
            position: '',
            cost: '',
            pageNum: 1,
            pageSize: 10,
            total: 0,

            form: {
                chargeId: '',
                chargeName: '',
                position: '',
                cost: '',
                applicant: localStorage.getItem('userId')
            },
            selectedRows: []
        };
    },
    methods: {
        // 勾选
        handleSelectionChange(val) {
            this.selectedRows = val;
        },
        //分页查询
        getData() {
            axios.get(`${process.env.VUE_APP_API_URL}/charge/getByPage2`, {
                params: {
                    pageNum: this.pageNum,
                    pageSize: this.pageSize
                }
            }).then(res => {
                console.log(res.data);
                this.tableData = res.data.records;
                // console.log(res.data.records);
                // console.log(this.tableData);
                this.total = res.data.total;
                this.pageNum = res.data.current;
                this.pageSize = res.data.size;
            })
        },
        //分页
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
        /* 查询 */
        query() {
            axios.get(`${process.env.VUE_APP_API_URL}/charge/getByPosition1`, {
                params: {
                    position: this.position
                }
            }).then(res => {
                console.log(res.data);
                this.tableData = res.data;
            })
        },
        /* 更新 */
        /* 更新选择的设备并插入申请记录 */
        updateSelectedEquipments() {
            if (this.selectedRows.length === 0) {
                this.$message.warning('请至少选择一项设备进行更新！');
                return;
            }

            const owningId = 1; // 从本地存储获取 owningId  
            const chargeIds = this.selectedRows.map(row => row.chargeId);
            const applicant = localStorage.getItem('userId'); // 获取申请人的 ID  
            const applyTime = new Date().toISOString(); // 获取当前时间  

            // 构建更新设备请求  
            const updateRequests = chargeIds.map(chargeId => {
                return axios.post(`${process.env.VUE_APP_API_URL}/charge/update`, {
                    owningId: owningId,
                    chargeId: chargeId
                });
            });

            // 构建插入申请记录请求  
            const insertApplyRequests = chargeIds.map(chargeId => {
                return axios.post(`${process.env.VUE_APP_API_URL}/apply/add`, {
                    chargeId: chargeId,
                    applyTime: applyTime,
                    applyStatus: '审批中',
                    applicant: applicant
                });
            });

            // 使用 Promise.all 来处理并发的请求  
            Promise.all([...updateRequests, ...insertApplyRequests])
                .then(responses => {
                    console.log('所有设备更新和申请记录插入成功：', responses);
                    this.selectedRows = [];  // 清空选择  
                    this.dialogVisible = false;  // 关闭弹窗  
                    this.getData(); // 更新表格数据  
                    this.$message.success('所有设备更新及申请记录插入成功！');
                })
                .catch(error => {
                    console.error('设备更新或申请记录插入出现错误：', error);
                    this.$message.error('设备更新或申请记录插入出现错误：' + error.message);
                });
        },

        handleClose() {
            this.dialogVisible = false;
        },

    }
}



</script>

<style>
.selection {
    background-color: #dde7f8;
    ;
    /* 行的背景色 */
}

.el-table__header .cell .el-checkbox__inner:not(.is-checked):not(.is-indeterminate) {
    background-color: #f8f9fa;
    /* 设置背景颜色为灰色 */
    border-color: #969494;
    /* 设置边框颜色为灰色 */
    width: 25px;
    height: 25px;
}

/* 自定义选中状态下的选择框样式 */
.el-table__header .cell .el-checkbox__inner.is-checked,
.el-table__header .cell .el-checkbox__inner.is-indeterminate {
    background-color: #409EFF;
    /* 设置背景颜色 */
    border-color: #409EFF;
    /* 设置边框颜色 */
    width: 55px;
    height: 55px;
}
</style>