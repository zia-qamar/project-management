# frozen_string_literal: true

class ContextMenuComponent < ViewComponent::Base
  attr_reader :id, :classes

  def initialize(id: "", classes: "", data: {})
    @id = id
    @classes = classes
    @data = data
  end

  def data
    @data[:controller] = @data[:controller].to_s + " context-menu"
    @data.merge(context_menu_target: "menu")
  end

  renders_one :toggle, "ToggleComponent"
  renders_one :drop, "DropComponent"

  class ToggleComponent < ViewComponent::Base
    attr_reader :classes, :data

    def initialize( classes: "", data: {})
      @classes = classes
      @data = data
    end

    def call
      content
    end
  end

  class DropComponent < ViewComponent::Base
    DROP_CLASS_BASE = "c-context-menu__drop"
    attr_reader :modifiers

    def initialize(modifiers: %w[bottom left])
      @modifiers = (modifiers.map { |c| DROP_CLASS_BASE + "--#{c}" } << DROP_CLASS_BASE).join(" ")
    end

    def call
      content
    end
  end
end
