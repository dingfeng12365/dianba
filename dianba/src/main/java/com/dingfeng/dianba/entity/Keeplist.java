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
@TableName("keeplist")
public class Keeplist implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "keepId", type = IdType.AUTO)
    private Integer keepId;

    @TableField("chargeId")
    private Integer chargeId;

    @TableField("pchargeId")
    private Integer pchargeId;

    @TableField("keepTime")
    private LocalDateTime keepTime;

    @TableField("faultDescription")
    private String faultDescription;

    @TableField("done")
    private String done;


}
