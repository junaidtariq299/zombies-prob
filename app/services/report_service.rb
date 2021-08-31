class ReportService
    def create_report
        {
            non_infected_survivors_percentage: calc_non_infected_survivors_percentage,
            infected_survivors_percentage: calc_infected_survivors_percentage,
            resource_average: calc_resource_average,
            points_lost: calc_points_lost
        }
    end

    private

    def calc_infected_survivors_percentage
        (Survivor.infected.count.to_f / Survivor.count * 100).round 2
    end

    def calc_non_infected_survivors_percentage
        (Survivor.not_infected.count.to_f / Survivor.count * 100).round 2
    end

    def calc_resource_average
        survivors = calc_survivors_count
        resource_average = []
        InventoryItem.not_finished.for_not_infected.group(:item_id).sum(:quantity).each do |id, quantity|
            resource_average << {id: id, name: Item.find(id).name, average: (quantity.to_f/survivors).round(2)}
        end
        resource_average
    end

    def calc_points_lost
        points_lost = 0
        InventoryItem.not_finished.for_infected.each do |inventory_item|
            points_lost = points_lost + inventory_item.quantity * inventory_item.item.points
        end
        points_lost
    end

    def calc_survivors_count
        Survivor.where(infected: false).count
    end

end