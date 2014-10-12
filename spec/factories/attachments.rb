# == Schema Information
#
# Table name: attachments
#
#  id             :integer          not null, primary key
#  archive_id     :integer          not null
#  name           :string(255)      not null
#  mime           :string(255)      not null
#  is_image       :boolean
#  content_base64 :text             not null
#  created_at     :datetime
#  updated_at     :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    archive_id 1
    name "paddle.png"
    mime "image/png"
    is_image true
    content_base64 "iVBORw0KGgoAAAANSUhEUgAAABQAAAAgCAYAAAASYli2AAADD0lEQVRIS2NkwA8cgNL2QCwAxIxA/B6IDwDxQVzaQIqwgQZuZqZsDiYmLj0+blYdfh5WkKKH377/Ovr2059vf/99+f7v3zSgUCO6ZnQDBTiYGE9IcbDLNWkqcJoL8mG17eT7Twx11x98f/L95/1f//9bAxV9gClENlCAjZHxqoe4oEivjgobgaBg+PT7D0PjzQe/dr16f//Hv/8WMEPhBgK9t8xSkDdklqE62HvEAvdjl76/+PFr4bd//zJBemAGOgAN3HXU1oCVj5WFWLPA6oDeZvA4funXz3//3UERBjaQk5nxRJGyrHmCnARJhsEUT7r3lGHew2e7v/797wYyEJQk3p+1N2Ig1XUwA0GudDx6EexjkIEOomysO47ZGbKT5TyoJt19Z37/+PfPDGygDi/3hvXm2vyUGBh48urHK5+/BtDGQBE2lq3H7Yy4KHGh6p5TIO2GsGTzf7+1PoMMJ3nBeO3zV4aQU9e+//7/nwtsIDcz464keSnXPCVpshxZcuXO752vPqwBRkoUVRI2NMkoAl3zAJ71QIk7UU7SoFBZhiR/I7sOOeuB2ApAfJ+UsASVOonnboLCTgvkOnQDGbiYmKZr8HAmrDTT5iAmMIEFw4973350AtU2wNRjlIfsTIw3+nVUxF3FBPGaCcq/sx88uwUsutSRFWIrsQM4mZhWH7E1YMGVt6ElzA9gCWMJNOwCIQMZ2BgZttoI87vONMBeNiafv/n9zPvP8DKQoIFABQKsjIzP5hupY1QDSBEhBVQHL/pxhSGyZQ1GfNzl6BEUdurqz/OfvnYgRwQxLgSpAbtyjZkWpxYvN1gPUhbD6jqMZIMeraB6JlxaNLJGXR4sBaqU1j19Mw9Wf2BLBrjqZZjaAGBJtBRWEpkfPPf13e8/NugxS6yXweqAFf6bZSaawiB2xOnrr4EVvBi+BErIhQwwb4MMWfn09XJQiUKRgUDNAYqc7Iv/ASugh99/xgD5Gyg1EFwrQg0B5UeMtEdSGIIU8zAz3WFkZPzw+c9fE3yuI5hskDRPgLILCBkIAHuPMhA9IGIVAAAAAElFTkSuQmCC"
  end
end
