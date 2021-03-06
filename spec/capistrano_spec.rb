describe "mokhan-myface::capistrano" do
  subject do
    ChefSpec::SoloRunner.new do |node|
      node.set["capistrano"]["root_path"] = root_path
      node.set["capistrano"]["username"] = username
      node.set["postgres"]["database"] = "app"
      node.set["postgres"]["username"] = username
      node.set["postgres"]["password"] = "password"
      node.set["postgres"]["host"] = "localhost"
    end.converge(described_recipe)
  end
  let(:root_path) { "/var/www/#{FFaker::Internet.domain_name}"  }
  let(:shared_path) { "#{root_path}/shared" }
  let(:username) { "deployer" }

  before :each do
    stub_command("stat -c %U #{root_path} | grep root").and_return(nil)
  end

  it "creates the root directory for the application" do
    expect(subject).to create_directory(root_path)
      .with_owner(username)
      .with_group(username)
      .with_mode("0755")
  end

  it "creates the shared directory for the application" do
    expect(subject).to create_directory("#{root_path}/shared")
      .with_owner(username)
      .with_group(username)
      .with_mode("0755")
  end

  it "creates all the shared folders" do
    directories = [
      "#{shared_path}/backups",
      "#{shared_path}/bundle",
      "#{shared_path}/config",
      "#{shared_path}/log",
      "#{shared_path}/tmp/sockets",
      "#{shared_path}/tmp/pids",
      "#{shared_path}/tmp/cache",
      "#{root_path}/releases"
    ]
    directories.each do |directory|
      expect(subject).to create_directory(directory)
        .with_owner(username)
        .with_group(username)
        .with_mode("0755")
    end
  end

  it "lays down the .env template" do
    expect(subject).to create_template("#{shared_path}/.env._default")
      .with_owner(username)
      .with_group(username)
      .with_mode("0600")
  end
end
