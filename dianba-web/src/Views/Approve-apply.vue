<template>
    <div>
        <div>
            <el-divider content-position="center">
                <h2>申请审批</h2>
            </el-divider>
            <el-divider content-position="left">
                <h3>申请信息查询</h3>
            </el-divider>
            <br />
            <!-- 输入框搜索 -->
            <div style="display: flex; align-items: center;">
                <el-input placeholder="请输入设备地址" prefix-icon="el-icon-search" v-model="applicant"
                    style="width: 300px; margin-left: 70px; margin-right: 10px;"> <!-- Adjusted margin-left -->
                </el-input>
                <el-button @click="query()" type="primary" icon="el-icon-search">搜索</el-button>

                <!-- 筛选 -->

                <el-select v-model="q.applyStatus" placeholder="选择状态" popper-class="custom-popper"
                    style="margin-left: 50px;">
                    <el-option v-for="item in options" :key="item.value" :label="item.label"
                        :value="item.value"></el-option>
                </el-select>

            </div>
            <br />

            <el-divider content-position="left">
                <h3>申请信息</h3>
            </el-divider>
        </div>

        <!-- 表格 -->
        <el-table :data="tableData" border style="width: 100%">
            <el-table-column prop="applyId" label="申请编号" width="180">
            </el-table-column>
            <el-table-column prop="chargeId" label="设备编号" width="180">
            </el-table-column>
            <el-table-column prop="applyTime" label="申请日期">
            </el-table-column>
            <el-table-column prop="applyStatus" label="审批状态">
            </el-table-column>
            <el-table-column prop="applicant" label="申请人">
            </el-table-column>
            <el-table-column label="操作" align="center">
                <template slot-scope="scope">
                    <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">审批</el-button>
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

        <!-- 审批弹窗 -->
        <el-dialog title="申请审批" :visible.sync="dialogVisible" width="30%" :before-close="handleClose">
            <span>
                <el-form ref="form" :model="form" label-width="80px">
                    <el-form-item label="审批编号">
                        <el-input :disabled="true" v-model="form.applyId"></el-input>
                    </el-form-item>
                    <el-form-item label="设备编号">
                        <el-input :disabled="true" v-model="form.chargeId"></el-input>
                    </el-form-item>
                    <el-form-item label="申请时间">
                        <el-input :disabled="true" v-model="form.applyTime"></el-input>
                    </el-form-item>
                    <el-form-item label="申请状态">
                        <el-select v-model="form.applyStatus" placeholder="请选择">
                            <el-option v-for="item in options1" :key="item.value" :label="item.label"
                                :value="item.value">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="申请人ID">
                        <el-input :disabled="true" v-model="form.applyId"></el-input>
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
    mounted() {
        this.getData();
    },
    data() {
        return {
            tableData: {},
            pageNum: 1,
            pageSize: 10,
            total: 0,
            applyId: '',
            chargeId: '',
            applyTime: '',
            applyStatus: '',
            applicant: '',
            dialogVisible: false,
            form: {
                applyId: '',
                chargeId: '',
                applyTime: '',
                applyStatus: '',
                applicant: '',
            },
            q: {
                applyStatus: ''
            },
            options: [
                { value: '已完成', label: '已完成' },
                { value: '审批中', label: '审批中' },
                { value: '未通过', label: '未通过' },
            ],
            options1: [
                { value: '已完成', label: '已完成' },
                { value: '未通过', label: '未通过' },
            ],
        }
    },
    watch: {
        'q.applyStatus': function (newValue) {
            this.queryDan(newValue);
        }
    },
    methods: {
        // 分页查询
        /* 获取数据 */
        getData() {
            axios.get(`${process.env.VUE_APP_API_URL}/apply/getByPage`, {
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
        /* 查询 */
        query() {
            axios.get(`${process.env.VUE_APP_API_URL}/apply/getByApplicant`, {
                params: {
                    applicant: this.applicant
                }
            }).then(res => {
                console.log(res.data);
                this.tableData = res.data;
            })
        },
        /* 单选查询 */
        queryDan() {
            axios.get(`${process.env.VUE_APP_API_URL}/apply/getByApplyStatus1`, {
                params: {
                    applyStatus: this.q.applyStatus
                }
            }).then(res => {
                console.log(res.data);
                this.tableData = res.data;
            })
        },
        /* 编辑 */
        handleEdit(index, row) {
            console.log(index, row);
            this.dialogVisible = true;
            this.form = row;
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
        /* 更新 */
        update() {
            // 根据审批状态决定 owningId 的值  
            let owningIdValue;
            if (this.form.applyStatus == '已完成') {
                owningIdValue = this.form.applicant;
            } else if (this.form.applyStatus == '未通过') {
                owningIdValue = 0; // 如果审批状态是“未通过”，将 owningId 设置为 null  
            } else {
                owningIdValue = 0; // 其他状态也可以设置为 null，视需求而定  
            }

            // 更新 charge 表中的 owningId  
            const updateChargeData = {
                chargeId: this.form.chargeId, // 保留 chargeId 以确保能够找到正确的记录  
                owningId: owningIdValue // 在这里设置 owningId  
            };

            // 更新 apply 表的审批状态  
            const updateApplyData = {
                applyId: this.form.applyId,
                applyStatus: this.form.applyStatus // 使用当前表单中的审批状态  
            };

            // 执行更新操作  
            Promise.all([
                axios.post(`${process.env.VUE_APP_API_URL}/charge/update`, updateChargeData),
                axios.post(`${process.env.VUE_APP_API_URL}/apply/update`, updateApplyData) // 更新 apply 表  
            ])
                .then(responses => {
                    console.log(responses);
                    this.dialogVisible = false; // 关闭弹窗  
                    this.getData(); // 重新获取数据，以更新表格  
                })
                .catch(error => {
                    console.error(error);
                });
        },
    }
}

</script>

<style></style>