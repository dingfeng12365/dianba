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
 * @since 2024-08-19
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("charge")
public class Charge implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "chargeId", type = IdType.AUTO)
    private Integer chargeId;

    @TableField("chargeName")
    private String chargeName;

    @TableField("launch")
    private Boolean launch;

    @TableField("position")
    private String position;

    @TableField("zhuangTai")
    private String zhuangTai;

    @TableField("maintenanceTime")
    private LocalDateTime maintenanceTime;

    @TableField("owningId")
    private Integer owningId;

    @TableField("cost")
    private Integer cost;

    @TableField("powerConsumption")
    private Integer powerConsumption;

}
