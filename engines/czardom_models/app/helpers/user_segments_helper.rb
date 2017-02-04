module UserSegmentsHelper

  def nested_segments_json(items)
    items.map do |item, children|
      hash = segment_hash(item)
      hash[:children] = children.map { |c, s| segment_hash(c) } unless children.blank?
      hash
    end.to_json
  end

  private

  def segment_hash(item)
    {
      id: item.id,
      name: item.name
    }
  end

end
