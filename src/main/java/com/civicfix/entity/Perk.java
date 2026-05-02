package com.civicfix.entity;

import javax.persistence.*;

@Entity
@Table(name = "perks")
public class Perk {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "cost_karma", nullable = false)
    private Integer costKarma;

    @Column(name = "icon_class")
    private String iconClass;

    @Column(name = "is_active")
    private boolean isActive = true;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getCostKarma() { return costKarma; }
    public void setCostKarma(Integer costKarma) { this.costKarma = costKarma; }

    public String getIconClass() { return iconClass; }
    public void setIconClass(String iconClass) { this.iconClass = iconClass; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}
