package com.dingfeng.dianba.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author dingfeng
 * @since 2024-08-23
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("apply")
public class Apply implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "applyId", type = IdType.AUTO)
    private Integer applyId;

    @TableField("chargeId")
    private Integer chargeId;

    @TableField("applyTime")
    private LocalDateTime applyTime;

    @TableField("applyStatus")
    private String applyStatus;

    @TableField("applicant")
    private Integer applicant;


}
