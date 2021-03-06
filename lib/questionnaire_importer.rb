class QuestionnaireImporter
  class << self

    def import_phases(program, program_data)
      # Phases
      program_data['phases'].each do |phase_data|
        phase = program.phases.create!(name: phase_data['name'],
                                       headline: phase_data['headline'],
                                       description: phase_data['description'])

        self.import_sections_for_phase(phase, phase_data)
      end

    end

    def import_sections_for_phase(phase, phase_data)
      base_sections_data = YAML.load_file(File.join(Rails.root, "db/seed_data/sections.yml"))

      phase_data['sections'].each do |section_data|
        section = base_sections_data['sections'].find do |section|
          section['name'] == section_data['name']
        end

        if section
          self.import_section_for_phase(phase, section)
        else
          puts "No section by name: #{section_data['name']}"
        end
      end
    end

    def import_section_for_phase(phase, section_data)
      section = phase.sections.create!(:name => section_data['name'],
                                       :headline => section_data['headline'],
                                       :description => section_data['description'],
                                       :code => section_data['code'])
      if section_data['steps']
        section_data['steps'].each do |step_data|
          import_step_for_section(section, step_data)
        end
      end

      unless ["obstacles", "rank-factors-per-career"].include?(section.slug)
        section.section_steps.create!(:type => "ConclusionStep")
      end
    end

    def import_step_for_section(section, step_data)
      step_options = {:template => step_data['template_name'],
                      :headline => step_data['headline'],
                      :description => step_data['description']}

      if step_data['step_type'] == "Question"
        import_question_for_section(section, step_data, step_options)
      elsif step_data['step_type'] == "Static"
        section.section_steps.create!(step_options.merge(:type => "StaticStep"))
      elsif step_data['step_type'] == "ResponseSelectionStep"
        section.section_steps.create!(step_options.merge(:type => "ResponseSelectionStep"))
      elsif step_data['step_type'] == "ResponseSelectionSummaryStep"
        section.section_steps.create!(step_options.merge(:type => "ResponseSelectionSummaryStep"))
      elsif step_data['step_type'] == "ResponseDistributionStep"
        section.section_steps.create!(step_options.merge(:type => "ResponseDistributionStep"))
      elsif step_data['step_type'] == "ConclusionStep"
        section.section_steps.create!(step_options.merge(:type => "ConclusionStep"))
      end
    end

    def import_question_for_section(section, step_data, step_options)
      question = Question.create!(:prompt => step_data['prompt'],
                                  :prompt_type => step_data['type'],
                                  :description => step_data['description'],
                                  :headline => step_data['headline'])
      if step_data['responses']
        step_data['responses'].each do |response_data|
          cheetah_factor = nil
          if response_data['rating_prompt']
            cheetah_factor = CheetahFactor.create!(:rating_prompt => response_data['rating_prompt'],
                                                   :career_rating_prompt => response_data['career_rating_prompt'])
          end

          option = question.response_options.create!(:description => response_data['description'],
                                                     :factor => Factor.find_by(:element_code => response_data['element_code']),
                                                     :fit_code => response_data['fit_code'],
                                                     :description => response_data['description'],
                                                     :work_zone => response_data['work_zone'],
                                                     :response_type => response_data['type'],
                                                     :cheetah_factor => cheetah_factor)
        end
      end

      section.section_steps.create!(step_options.merge(:type => "QuestionStep", :question => question))
    end
  end
end
