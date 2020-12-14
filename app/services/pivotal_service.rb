class PivotalService

  attr_accessor :client

  def initialize
    @client = TrackerApi::Client.new(token: ENV['PIVOTAL_TOKEN'])
  end

  def update_projects
    @client.projects.map do |p|
      Project.find_or_create_by(pivotal_id: p.id) do |project|
        project.name = p.name
        project.pivotal_id = p.id
      end
    end
  end
end
